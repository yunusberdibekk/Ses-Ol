//
//  AuthService.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation

final class AuthService {
    func login(phoneNumber: String, password: String) async -> Result<LoginResponse, AuthError > {
        let validateResult = AuthValidator.shared.loginValidator(phone: phoneNumber, password: password)
        if let validateResult = validateResult { return .failure(validateResult) }
        let result = await NetworkManager.shared.auth(url: .login, method: .post, model: LoginRequest(user_tel: phoneNumber, user_password: password), type: LoginResponse.self)
        return result
    }

    func unionSignup(method: String, unionName: String, unionPhone: String, unionEmail: String,
        unionWebSite: String, unionPassword: String) async -> Result<UnionSignupResponse, AuthError> {
        let validateResult = AuthValidator.shared.unionSignupValidator(unionName: unionName, unionPhone: unionPhone, unionEmail: unionEmail, unionWebSite: unionWebSite, unionPassword: unionPassword)
        if let validateResult = validateResult { return.failure(validateResult) }
        let result = await NetworkManager.shared.auth(url: .unionsCrud, method: .post, model: UnionSignupRequest(method: method, union_name: unionName, union_tel: unionPhone, union_email: unionEmail, union_web_site: unionWebSite, union_password: unionPassword), type: UnionSignupResponse.self)
        return result
    }

    func citizienSignup(method: String, citizienName: String, citizienSurname: String, citizienPassword: String, citizienPhone: String, citizienCountry: String, citizienCity: String, citizienDistrict: String, citizienFullAddress: String) async -> Result<CitizienSignupResponse, AuthError> {
        let validateResult = AuthValidator.shared.citizienSignupValidator(citizienName: citizienName, citizienSurname: citizienSurname, citizienPassword: citizienPassword, citizienPhone: citizienPhone, citizienCountry: citizienCountry, citizienCity: citizienCity, citizienDistrict: citizienDistrict, citizienFullAddress: citizienFullAddress)
        if let validateResult = validateResult { return.failure(validateResult) }
        let result = await NetworkManager.shared.auth(url: .usersCrud, method: .post, model: CitizienSignupRequest(method: method, user_tel: citizienPhone, user_password: citizienPassword, user_name: citizienName, user_surname: citizienSurname, address_district: citizienDistrict, address_city: citizienCity, address_country: citizienCountry, user_full_address: citizienFullAddress), type: CitizienSignupResponse.self)
        return result
    }


    func logout() -> AuthError? { return nil }
}
