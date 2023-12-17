//
//  AuthValidator.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation

final class AuthValidator {
    static let shared = AuthValidator()

    func loginValidator(phone: String, password: String) -> AuthError? {
        if phone.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhone.rawValue)
        }

        if password.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPassword.rawValue)
        }

        if phone.count < 11 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhoneLenght.rawValue)
        }

        if password.count < 6 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPasswordLenght.rawValue)
        }

        return nil
    }

    func citizienSignupValidator(citizienName: String, citizienSurname: String, citizienPassword: String, citizienPhone: String,
                                 citizienCountry: String, citizienCity: String, citizienDistrict: String, citizienFullAddress: String) -> AuthError?
    {
        if citizienName.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidName.rawValue)
        }

        if citizienSurname.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidSurname.rawValue)
        }

        if citizienPhone.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhone.rawValue)
        }

        if citizienPassword.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPassword.rawValue)
        }

        if citizienCountry.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidCountry.rawValue)
        }

        if citizienCity.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidCity.rawValue)
        }

        if citizienDistrict.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidDistrict.rawValue)
        }

        if citizienFullAddress.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidFullAdres.rawValue)
        }

        if citizienPhone.count < 11 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhoneLenght.rawValue)
        }

        if citizienPassword.count < 6 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPasswordLenght.rawValue)
        }

        return nil
    }

    func unionSignupValidator(unionName: String, unionPhone: String, unionEmail: String, unionWebSite: String, unionPassword: String) -> AuthError? {
        if unionName.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidName.rawValue)
        }

        if unionEmail.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidEmail.rawValue)
        }

        if unionWebSite.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidWebsite.rawValue)
        }

        if unionPassword.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPassword.rawValue)
        }

        if unionPhone.isEmpty {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhone.rawValue)
        }

        if !(unionEmail.contains("@") && unionEmail.contains(".co")) {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidEmailFormat.rawValue)
        }

        if unionPhone.count < 11 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPhoneLenght.rawValue)
        }

        if unionPassword.count < 6 {
            return AuthError.authError(description: AuthValidatorErrorKeys.invalidPasswordLenght.rawValue)
        }

        return nil
    }
}

enum AuthValidatorErrorKeys: String {
    case invalidLogin = "Login error"
    case invalidSignup = "Signup error"
    case invalidSignout = "Signout error"

    case invalidPhoneLenght = "Phone length must be a minimum of 11 characters."
    case invalidPasswordLenght = "Password length must be a minimum of 6 characters."
    case invalidPassword = "Password cannot be empty"
    case invalidName = "Name cannot be empty"
    case invalidSurname = "Surname cannot be empty"
    case invalidPhone = "Phone cannot be empty"
    case invalidCountry = "Country cannot be empty"
    case invalidCity = "City cannot be empty"
    case invalidDistrict = "District cannot be empty"
    case invalidFullAdres = "Fulladress cannot be empty"
    case invalidEmail = "Email cannot be empty"
    case invalidEmailFormat = "Bad email adress format"
    case invalidWebsite = "Website cannot be empty"
}
