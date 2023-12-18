//
//  LoginRequest.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 17.12.2023.
//

import Foundation

struct LoginRequest: Encodable {
    let user_tel: String
    let user_password: String
}
