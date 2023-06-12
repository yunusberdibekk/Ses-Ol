//
//  ProfileModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 23.05.2023.
//

import Foundation
// MARK: - CitizienProfileResponse
struct CitizienProfileResponse: Codable {
    var userAccountID: Int?
    var userName, userSurname, userTel, userPassword: String?
    var addressID: Int?
    var addressDistrict, addressCity, addressCountry, fullAddress: String?

    enum CodingKeys: String, CodingKey {
        case userAccountID = "user_account_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case userTel = "user_tel"
        case userPassword = "user_password"
        case addressID = "address_id"
        case addressDistrict = "address_district"
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case fullAddress = "full_address"
    }
}

struct CitizienProfileRequest: Codable {
    var method: String?
    var user_account_id: Int?
}

// MARK: - UnionProfileResponse
struct UnionProfileResponse: Codable {
    var userAccountID: Int?
    var unionName, unionTel, unionPassword, unionEmail: String?
    var unionWebSite: String?

    enum CodingKeys: String, CodingKey {
        case userAccountID = "user_account_id"
        case unionName = "union_name"
        case unionTel = "union_tel"
        case unionPassword = "union_password"
        case unionEmail = "union_email"
        case unionWebSite = "union_web_site"
    }
}

struct UnionProfileRequest: Codable {
    var method: String?
    var user_account_id: Int?
}

struct IbanCreateResponse: Codable {
    let status, msg: String?
}

// MARK: - IbanReadResponseElement
struct IbanReadResponseElement: Codable {
    var ibanID, userAccountID: Int?
    let ibanTitle, iban: String?

    enum CodingKeys: String, CodingKey {
        case ibanID = "iban_id"
        case userAccountID = "user_account_id"
        case ibanTitle = "iban_title"
        case iban
    }
}

typealias IbanReadResponse = [IbanReadResponseElement]

// MARK: - IbanUpdateResponse
struct IbanUpdateResponse: Codable {
    let status, msg: String?
}

// MARK: - IbanDeleteResponse
struct IbanDeleteResponse: Codable {
    let status, msg: String?
}


struct IbanCreateRequest: Encodable {
    let method: String?
    let user_account_id: Int?
    let iban_title: String?
    let iban: String?
}
struct IbanReadRequest: Encodable {
    let method: String?
    let user_account_id: Int?
}

struct IbanUpdateeRequest: Encodable {
    let method: String?
    let iban_id: Int?
    let iban_title: String?
    let iban: String?
}
struct IbanDeleteRequest: Encodable {
    let method: String?
    let iban_id: Int?
}
