//
//  IbanResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

struct IbanCreateResponse: Codable {
    let status, msg: String
}

struct IbanReadResponseElement: Codable, Identifiable, Hashable {
    var id, userAccountID: Int
    let ibanTitle, iban: String

    enum CodingKeys: String, CodingKey {
        case id = "iban_id"
        case userAccountID = "user_account_id"
        case ibanTitle = "iban_title"
        case iban
    }

    static let mockIbanReadResponseElement: IbanReadResponseElement = .init(
        id: 1,
        userAccountID: 1,
        ibanTitle: "Ziraat Bankası",
        iban: UUID().uuidString)
}

struct IbanUpdateResponse: Codable {
    let status, msg: String
}

struct IbanDeleteResponse: Codable {
    let status, msg: String
}
