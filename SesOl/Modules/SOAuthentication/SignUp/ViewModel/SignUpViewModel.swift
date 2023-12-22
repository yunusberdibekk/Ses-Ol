//
//  SignUpViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.04.2023.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var userType: UserType = .citizien
    @Published var locationCountriesResponse: [LocationResponseElement] = []
    @Published var locationCitiesResponse: [LocationResponseElement] = []
    @Published var locationDistrictsResponse: [LocationResponseElement] = []
    
    @Published var countries = [Country]()
    @Published var cities = [City]()
    @Published var districts = [District]()
    
    @Published var citizienName = ""
    @Published var citizienSurname = ""
    @Published var citizienPassword = ""
    @Published var citizienPhone = ""
    @Published var citizienFullAddress = ""
    
    @Published var unionName = ""
    @Published var unionPhone = ""
    @Published var unionPassword = ""
    @Published var unionEmail = ""
    @Published var unionWebsite = ""
    
    @Published var selectedCountry: Country = .mockCountry1
    @Published var selectedCity: City = .mockCity1
    @Published var selectedDistrict: District = .mockDistrict1
    
    @Published var logMessage: String = ""
    @Published var logStatus: Bool = false
    
    func getLocations() async {
        let response = await NetworkManager.shared.fetch(
            url: .getLocationInfo,
            method: .get,
            type: [[LocationResponseElement]].self)
        
        switch response {
        case .success(let success):
            let (countries, cities, districts) = await parseLocationResponse(response: success)
            await updateFirstLocations(countries: countries,
                                       cities: cities,
                                       districts: districts)
        case .failure(let error):
            showAlert(message: error.localizedDescription)
        }
    }
    
    func citizienSignUp() async {
        guard isValidateCitizienValues() else { return }
        let response = await NetworkManager.shared.post(
            url: .usersCrud,
            method: .post, model: CitizienSignupRequest(
                method: "create_user",
                user_tel: citizienPhone,
                user_password: citizienPassword,
                user_name: citizienName,
                user_surname: citizienSurname,
                address_district: selectedDistrict.ilceAdi,
                address_city: selectedCity.sehirAdi,
                address_country: selectedCountry.ulkeAdi,
                user_full_address: citizienFullAddress),
            type: CitizienSignUpResponse.self)
        switch response {
        case .success(let result):
            if result.status == "ok" {
                showAlert(message: "Kayıt olma işlemi başarıyla sonuçlandı.")
            } else {
                showAlert(message: "Kayıt olma işlemi başarıyla sonuçlanmadı.")
            }
        case .failure(let error):
            showAlert(message: error.localizedDescription)
        }
    }
    
    func unionSignUp() async {
        guard isValidateUnionValues() else { return }
        let response = await NetworkManager.shared.post(
            url: .unionsCrud,
            method: .post,
            model: UnionSignupRequest(
                method: "create",
                union_name: unionName,
                union_tel: unionPhone,
                union_email: unionEmail,
                union_web_site: unionWebsite,
                union_password: unionPassword),
            type: UnionSignUpResponse.self)
   
        switch response {
        case .success(let result):
            if result.status == "ok" {
                showAlert(message: "Kayıt olma işlemi başarıyla sonuçlandı.")
            } else {
                showAlert(message: "Kayıt olma işlemi başarıyla sonuçlanmadı.")
            }
        case .failure(let error):
            showAlert(message: error.localizedDescription)
        }
    }
    
    func signUp() async {
        switch userType {
        case .citizien:
            await citizienSignUp()
        case .union:
            await unionSignUp()
        }
    }
    
    @MainActor
    /// Test
    func updateMockLocations() {
        countries = Country.mockCountriesResponse
        cities = City.mockCitiesResponse.filter { $0.ulkeIDFK == self.selectedCountry.ulkeID }
        districts = District.mockDistrictsResponse.filter { $0.sehirIDFK == self.selectedCity.sehirID }
    }
    
    @MainActor
    func updateLocations() {
        let countries: [Country] = locationCountriesResponse.compactMap {
            Country(id: UUID().uuidString, ulkeID: $0.ulkeID, ulkeAdi: $0.ulkeAdi)
        }
        let cities: [City] = locationCitiesResponse.compactMap {
            City(id: UUID().uuidString, sehirID: $0.sehirID, sehirAdi: $0.sehirAdi, ulkeIDFK: $0.ulkeIDFk)
        }
        let districts: [District] = locationDistrictsResponse.compactMap {
            District(id: UUID().uuidString, ilceID: $0.ilceID, ilceAdi: $0.ilceAdi, sehirIDFK: $0.sehirIDFK)
        }
        
        self.countries = countries
        self.cities = cities.filter { $0.ulkeIDFK == self.selectedCountry.ulkeID }
        self.districts = districts.filter { $0.sehirIDFK == self.selectedCity.sehirID }
    }
    
    @MainActor
    private func parseLocationResponse(response: [[LocationResponseElement]]) -> ([Country], [City], [District]) {
        guard response.count == 3 else { return ([], [], []) }
        locationCountriesResponse = response[0]
        locationCitiesResponse = response[1]
        locationDistrictsResponse = response[2]
        
        let countries: [Country] = locationCountriesResponse.compactMap {
            Country(id: UUID().uuidString, ulkeID: $0.ulkeID, ulkeAdi: $0.ulkeAdi)
        }
        let cities: [City] = locationCitiesResponse.compactMap {
            City(id: UUID().uuidString, sehirID: $0.sehirID, sehirAdi: $0.sehirAdi, ulkeIDFK: $0.ulkeIDFk)
        }
        let districts: [District] = locationDistrictsResponse.compactMap {
            District(id: UUID().uuidString, ilceID: $0.ilceID, ilceAdi: $0.ilceAdi, sehirIDFK: $0.sehirIDFK)
        }
        return (countries, cities, districts)
    }
    
    @MainActor
    private func updateFirstLocations(countries: [Country], cities: [City], districts: [District]) {
        self.countries = countries
        self.cities = cities.filter { $0.ulkeIDFK == self.selectedCountry.ulkeID }
        self.districts = districts.filter { $0.sehirIDFK == self.selectedCity.sehirID }
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.async {
            self.logMessage = message
            self.logStatus.toggle()
        }
    }
    
    private func isValidateCitizienValues() -> Bool {
        guard !citizienName.isEmpty else {
            showAlert(message: "Vatandaş adı boş olamaz.")
            return false
        }
        guard !citizienSurname.isEmpty else {
            showAlert(message: "Vatandaş soyadı boş olamaz.")
            return false
        }
        guard citizienPhone.isValidPhone else {
            showAlert(message: "Telefon uzunluğu min. 8 olmalıdır.Özel karakterler içermemelidir.Ülke alan kodunu içermelidir.")
            return false
        }
        guard !citizienFullAddress.isEmpty else {
            showAlert(message: "Kullanıcı tam adresi boş olamaz.")
            return false
        }
        guard citizienPassword.count > 6 else {
            showAlert(message: "Kullanıcı şifresi min. 6 olmalıdır.")
            return false
        }
        return true
    }
    
    private func isValidateUnionValues() -> Bool {
        guard !unionName.isEmpty else {
            showAlert(message: "Vatandaş adı boş olamaz.")
            return false
        }
        guard unionPhone.isValidPhone else {
            showAlert(message: "Telefon uzunluğu min. 8 olmalıdır.Özel karakterler içermemelidir.Ülke alan kodunu içermelidir.")
            return false
        }
        guard unionEmail.isValidEmail else {
            showAlert(message: "Geçersiz email adresi.")
            return false
        }
        guard !unionWebsite.isEmpty else {
            showAlert(message: "Kullanıcı web sitesi boş olamaz.")
            return false
        }
        guard unionPassword.count > 6 else {
            showAlert(message: "Kullanıcı şifresi min. 6 olmalıdır.")
            return false
        }
        return true
    }
}
