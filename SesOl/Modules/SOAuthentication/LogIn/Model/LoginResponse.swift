//
//  LoginResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 17.12.2023.
//

import Foundation

struct LoginResponse: Codable {
    let userAccountID, isUnionAccount: Int

    enum CodingKeys: String, CodingKey {
        case userAccountID = "user_account_id"
        case isUnionAccount = "is_union_account"
    }
}
