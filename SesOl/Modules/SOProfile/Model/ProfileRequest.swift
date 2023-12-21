//
//  ProfileRequest.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

struct CitizienProfileRequest: Codable {
    var method: String
    var user_account_id: Int
}

struct UnionProfileRequest: Codable {
    var method: String
    var user_account_id: Int
}
