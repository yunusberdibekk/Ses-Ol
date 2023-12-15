//
//  ProfileResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
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
