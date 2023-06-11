//
//  LoginModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 24.04.2023.
//

import Foundation

struct LoginRequest: Encodable {
    let user_tel: String?
    let user_password: String?
}

struct LoginResponse: Codable {
    let userAccountID, isUnionAccount: Int?

    enum CodingKeys: String, CodingKey {
        case userAccountID = "user_account_id"
        case isUnionAccount = "is_union_account"
    }
}
