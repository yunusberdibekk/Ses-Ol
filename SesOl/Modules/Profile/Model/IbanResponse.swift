//
//  IbanResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

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

// MARK: - IbanUpdateResponse

struct IbanUpdateResponse: Codable {
    let status, msg: String?
}

// MARK: - IbanDeleteResponse

struct IbanDeleteResponse: Codable {
    let status, msg: String?
}
