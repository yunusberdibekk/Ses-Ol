//
//  SignUpViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.04.2023.
//

import Foundation
import Alamofire
import SwiftUI

final class SignupViewModel: ObservableObject {
    @Published var selectedOption = 0

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

    @Published var countries = [LocationResponseElement]()
    @Published var cities = [LocationResponseElement]()
    @Published var districts = [LocationResponseElement]()

    @Published var selectedCountry: Country = Country(ulke_id: "-1", ulke_adi: "Seç")
    @Published var selectedCity: City = City(sehir_id: "-1", sehir_adi: "Seç", ulke_idfk: "-1")
    @Published var selectedDistrict: District = District(ilce_id: "-1", ilce_adi: "Seç", sehir_idfk: "-1")

    @Published var successfulRegistration: Bool = false
    @Published var unSuccessfulRegistration: Bool = false

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let errorManager = ErrorManager()

    func getLocations() async {
        let response = await getAllLocation()
        do {
            let (countries, cities, districts) = try await parseLocationResponse(response: response)

            DispatchQueue.main.async {
                self.countries = countries
            }

            DispatchQueue.main.async {
                self.cities = cities
            }

            DispatchQueue.main.async {
                self.districts = districts
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func signupCitizien() async -> String {
        let status = await onSignupCitizien(method: "create_user", citizienName: citizienName, citizienSurname: citizienSurname, citizienPassword: citizienPassword, citizienPhone: citizienPhone, citizienCountry: selectedCountry.ulke_adi, citizienCity: selectedCity.sehir_adi, citizienDistrict: selectedDistrict.ilce_adi, citizienFullAddress: citizienFullAddress)

        if status.lowercased() == "ok" {
            DispatchQueue.main.async {
                self.successfulRegistration = true
                self.unSuccessfulRegistration = false
            }

        } else {
            DispatchQueue.main.async {
                self.unSuccessfulRegistration = true
                self.successfulRegistration = false
            }
        }

        return status
    }

    func signupUnion() async -> String {

        let status = await onSignupUnion(method: "create", unionName: unionName, unionPhone: unionPhone, unionEmail: unionEmail, unionWebSite: unionWebsite, unionPassword: unionPassword)

        if status.lowercased() == "ok" {
            DispatchQueue.main.async {
                self.successfulRegistration = true
                self.unSuccessfulRegistration = false
            }
        } else {
            DispatchQueue.main.async {
                self.unSuccessfulRegistration = true
                self.successfulRegistration = false
            }
        }

        return status
    }

    func check(value1: String, value2: String) -> Bool {
        return value1 == value2 ? true : false
    }
}

extension SignupViewModel {
    func parseLocationResponse(response: LocationResponse) async throws -> ([LocationResponseElement], [LocationResponseElement], [LocationResponseElement]) {
        guard response.count == 3 else {
            throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
        }

        let ulkeler = response[0]
        let iller = response[1].filter { $0.ulkeIDFk == selectedCountry.ulke_id }
        let ilceler = response[2].filter { $0.sehirIDFk == selectedCity.sehir_id }
        return (ulkeler, iller, ilceler)
    }

    func onSignupCitizien(method: String, citizienName: String, citizienSurname: String, citizienPassword: String, citizienPhone: String, citizienCountry: String, citizienCity: String, citizienDistrict: String, citizienFullAddress: String) async -> String {
        guard !citizienName.isEmpty else { return CitizienErrors.emptyName.rawValue }
        guard !citizienSurname.isEmpty else { return CitizienErrors.emptySurname.rawValue }
        guard !citizienPassword.isEmpty else { return CitizienErrors.emptyPassword.rawValue }
        guard !citizienPhone.isEmpty else { return CitizienErrors.emptyPhone.rawValue }
        guard !citizienCountry.isEmpty else { return CitizienErrors.emptyCountry.rawValue }
        guard !citizienCity.isEmpty else { return CitizienErrors.emptyCity.rawValue }
        guard !citizienDistrict.isEmpty else { return CitizienErrors.emptyDistrict.rawValue }
        guard !citizienFullAddress.isEmpty else { return CitizienErrors.emptyFullAdress.rawValue }
        guard !(citizienCountry == "Seç") else { return CitizienErrors.emptyCountry.rawValue }
        guard !(citizienCity == "Seç") else { return CitizienErrors.emptyCity.rawValue }
        guard !(citizienDistrict == "Seç") else { return CitizienErrors.emptyDistrict.rawValue }

        let response = await networkManager.post(path: .usersCrud, model: CitizienSignupRequest(method: method, user_tel: citizienPhone, user_password: citizienPassword, user_name: citizienName, user_surname: citizienSurname, address_district: citizienDistrict, address_city: citizienCity, address_country: citizienCountry, user_full_address: citizienFullAddress), type: CitizienSignupResponse.self)

        return response?.status ?? CitizienErrors.error.rawValue
    }


    func getAllLocation() async -> LocationResponse {
        let response = await networkManager.fetch(path: .getLocationInfo, method: .get, type: LocationResponse.self)
        return response ?? LocationResponse()
    }

    func onSignupUnion(method: String, unionName: String, unionPhone: String, unionEmail: String, unionWebSite: String, unionPassword: String) async -> String {
        guard !unionName.isEmpty else { return UnionErrors.emptyName.rawValue }
        guard !unionPhone.isEmpty else { return UnionErrors.emptyPhone.rawValue }
        guard !unionEmail.isEmpty else { return UnionErrors.emptyEmail.rawValue }
        guard !unionWebSite.isEmpty else { return UnionErrors.emptyWebSite.rawValue }
        guard !unionPassword.isEmpty else { return UnionErrors.emptyPassword.rawValue }

        let response = await networkManager.post(path: .unionsCrud, model: UnionSignupRequest(method: method, union_name: unionName, union_tel: unionPhone, union_email: unionEmail, union_web_site: unionWebSite, union_password: unionPassword), type: UnionSignupResponse.self)

        return response?.status ?? UnionErrors.error.rawValue
    }
}

protocol SignUpUseCase {
    func getAllLocation() async -> LocationResponse
    func parseLocationResponse(response: LocationResponse) async throws -> ([LocationResponseElement], [LocationResponseElement], [LocationResponseElement])
    func onSignupCitizien(method: String, citizienName: String, citizienSurname: String, citizienPassword: String, citizienPhone: String, citizienCountry: String, citizienCity: String, citizienDistrict: String, citizienFullAddress: String
    ) async -> String

    func onSignupUnion(method: String, unionName: String, unionPhone: String, unionEmail: String, unionWebSite: String, unionPassword: String) async -> String
}
