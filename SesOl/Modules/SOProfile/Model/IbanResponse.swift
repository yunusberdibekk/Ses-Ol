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

    static let mockIbanReadResponseElement1: IbanReadResponseElement = .init(
        id: 1,
        userAccountID: 1,
        ibanTitle: "Ziraat Bankası",
        iban: UUID().uuidString)
    static let mockIbanReadResponseElement2: IbanReadResponseElement = .init(
        id: 1,
        userAccountID: 1,
        ibanTitle: "Halk Bankası",
        iban: UUID().uuidString)
    static let mockIbanReadResponseElement3: IbanReadResponseElement = .init(
        id: 1,
        userAccountID: 1,
        ibanTitle: "İş Bankası",
        iban: UUID().uuidString)
    static let mockIbanReadResponseElement4: IbanReadResponseElement = .init(
        id: 1,
        userAccountID: 1,
        ibanTitle: "VakıfBank",
        iban: UUID().uuidString)
}

struct IbanUpdateResponse: Codable {
    let status, msg: String
}

struct IbanDeleteResponse: Codable {
    let status, msg: String
}
