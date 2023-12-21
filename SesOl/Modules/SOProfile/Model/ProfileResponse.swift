//
//  ProfileResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

// MARK: - CitizienProfileResponse

struct CitizienProfileResponse: Codable {
    var userAccountID: Int
    var userName, userSurname, userTel, userPassword: String
    var addressID: Int
    var addressDistrict, addressCity, addressCountry, fullAddress: String

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

    static let mockCitizienProfileResponseElement: CitizienProfileResponse = .init(
        userAccountID: 1,
        userName: "Inanna",
        userSurname: "Mahin",
        userTel: "734(67)714-55-93",
        userPassword: UUID().uuidString,
        addressID: 1,
        addressDistrict: "Antakya",
        addressCity: "Hatay",
        addressCountry: "Türkiye",
        fullAddress: "CUMHURİYET MEYDANI S 41 NO 13 BEYDAN İŞH K.2 D 2/3 HATAY")
}

// MARK: - UnionProfileResponse

struct UnionProfileResponse: Codable {
    var userAccountID: Int
    var unionName, unionTel, unionPassword, unionEmail: String
    var unionWebSite: String

    enum CodingKeys: String, CodingKey {
        case userAccountID = "user_account_id"
        case unionName = "union_name"
        case unionTel = "union_tel"
        case unionPassword = "union_password"
        case unionEmail = "union_email"
        case unionWebSite = "union_web_site"
    }

    static let mockUnionProfileResponseElement: UnionProfileResponse = .init(
        userAccountID: 2,
        unionName: "AFAD",
        unionTel: "27(1705)183-98-53",
        unionPassword: UUID().uuidString,
        unionEmail: "gelisoy_ifu20@hotmail.com",
        unionWebSite: "https://www.afad.gov.tr")
}
