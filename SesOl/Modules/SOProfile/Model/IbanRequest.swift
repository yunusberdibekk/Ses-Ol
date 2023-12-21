//
//  IbanRequest.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

struct IbanCreateRequest: Encodable {
    let method: String
    let user_account_id: Int
    let iban_title: String
    let iban: String
}

struct IbanReadRequest: Encodable {
    let method: String
    let user_account_id: Int
}

struct IbanUpdateeRequest: Encodable {
    let method: String
    let iban_id: Int
    let iban_title: String
    let iban: String
}

struct IbanDeleteRequest: Encodable {
    let method: String
    let iban_id: Int
}
