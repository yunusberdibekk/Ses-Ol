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

    @Published var authError: AuthError?
    @Published var networkError: NetworkError?

    let authService = AuthService()

    func getLocations() async {
        let response = await NetworkManager.shared.fetch(url: .getLocationInfo, method: .get, type: LocationResponse.self)

        switch response {
        case .success(let success):
            do {
                let (countries, cities, districts) = try await parseLocationResponse(response: success)
                DispatchQueue.main.async {
                    self.countries = countries
                    self.cities = cities
                    self.districts = districts
                }
            } catch {
                print(error.localizedDescription)
            }

        case .failure(let failure):
            DispatchQueue.main.async {
                self.networkError = failure
            }
        }
    }

    func signupCitizien() async {
        let response = await authService.citizienSignup(method: "create_user", citizienName: citizienName, citizienSurname: citizienSurname, citizienPassword: citizienPassword, citizienPhone: citizienPhone, citizienCountry: selectedCountry.ulke_adi, citizienCity: selectedCity.sehir_adi, citizienDistrict: selectedDistrict.ilce_adi, citizienFullAddress: citizienFullAddress)

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

    func signupUnion() async {
        let response = await authService.unionSignup(method: "create", unionName: unionName, unionPhone: unionPhone, unionEmail: unionEmail, unionWebSite: unionWebsite, unionPassword: unionPassword)

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

    func check(value1: String, value2: String) -> Bool {
        return value1 == value2 ? true : false
    }

    private func parseLocationResponse(response: LocationResponse) async throws -> ([LocationResponseElement], [LocationResponseElement], [LocationResponseElement]) {
        guard response.count == 3 else {
            throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
        }

        let ulkeler = response[0]
        let iller = response[1].filter { $0.ulkeIDFk == selectedCountry.ulke_id }
        let ilceler = response[2].filter { $0.sehirIDFk == selectedCity.sehir_id }
        return (ulkeler, iller, ilceler)
    }
}
