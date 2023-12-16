//
//  SignUpViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.04.2023.
//

import SwiftUI

final class SignupViewModel: ObservableObject {
    @Published var userType: UserType = .citizien
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
    
    @Published var selectedCountry: Country = .init(
        id: UUID().uuidString,
        ulkeID: "1",
        ulkeAdi: "Türkiye")
    @Published var selectedCity: City = .init(
        id: UUID().uuidString,
        sehirID: "1",
        sehirAdi: "Adana",
        ulkeIDFK: "1")
    @Published var selectedDistrict: District = .init(
        id: UUID().uuidString,
        ilceID: "1",
        ilceAdi: "Seyhan",
        sehirIDFK: "1")
    
    @Published var successfulRegistration: Bool = false
    @Published var unSuccessfulRegistration: Bool = false
    @Published var authError: AuthError?
    @Published var networkError: NetworkError?
    
    let authService = AuthService()
    
    func getLocations() async {
        let response = await NetworkManager.shared.fetch(
            url: .getLocationInfo,
            method: .get,
            type: [[LocationResponseElement]].self)
        
        switch response {
        case .success(let success):
            let (countries, cities, districts) = parseLocationResponse(
                response: success)
            updateLocations(
                countries: countries,
                cities: cities,
                districts: districts)
        case .failure(let failure):
            DispatchQueue.main.async {
                self.networkError = failure
            }
        }
    }
    
    func citizienSignUp() async {
        let response = await authService.citizienSignup(
            method: "create_user",
            citizienName: citizienName,
            citizienSurname: citizienSurname,
            citizienPassword: citizienPassword,
            citizienPhone: citizienPhone,
            citizienCountry: selectedCountry.ulkeAdi,
            citizienCity: selectedCity.sehirAdi,
            citizienDistrict: selectedDistrict.ilceAdi,
            citizienFullAddress: citizienFullAddress)
        
        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.successfulRegistration = true
                        self.unSuccessfulRegistration = false
                        
                    } else {
                        self.unSuccessfulRegistration = true
                        self.successfulRegistration = false
                    }
                }
            case .failure(let failure):
                self.authError = failure
            }
        }
    }
    
    func unionSignUp() async {
        let response = await authService.unionSignup(
            method: "create",
            unionName: unionName,
            unionPhone: unionPhone,
            unionEmail: unionEmail,
            unionWebSite: unionWebsite,
            unionPassword: unionPassword)
        
        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.successfulRegistration = true
                        self.unSuccessfulRegistration = false
                        
                    } else {
                        self.unSuccessfulRegistration = true
                        self.successfulRegistration = false
                    }
                }
            case .failure(let failure):
                self.authError = failure
            }
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
    
    func updateLocations(countries: [Country], cities: [City], districts: [District]) {
        self.countries = countries
        self.cities = cities.filter { $0.ulkeIDFK == selectedCountry.ulkeID }
        self.districts = districts.filter { $0.sehirIDFK == selectedCity.sehirID }
    }
    
    private func parseLocationResponse(response: [[LocationResponseElement]]) -> ([Country], [City], [District]) {
        guard response.count == 3 else { return ([], [], []) }
        let countriesResponse = response[0]
        let citiesResponse = response[1]
        let districtsResponse = response[2]
        
        let countries: [Country] = countriesResponse.compactMap {
            Country(id: UUID().uuidString, ulkeID: $0.ulkeID, ulkeAdi: $0.ulkeAdi)
        }
        let cities: [City] = citiesResponse.compactMap {
            City(id: UUID().uuidString, sehirID: $0.sehirID, sehirAdi: $0.sehirAdi, ulkeIDFK: $0.ulkeIDFk)
        }
        let districts: [District] = districtsResponse.compactMap {
            District(id: UUID().uuidString, ilceID: $0.ilceID, ilceAdi: $0.ilceAdi, sehirIDFK: $0.sehirIDFK)
        }
        return (countries, cities, districts)
    }
}
