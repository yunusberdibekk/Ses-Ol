//
//  SignupRequest.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.12.2023.
//

import Foundation

struct CitizienSignupRequest: Encodable {
    var method: String?
    var user_tel: String?
    var user_password: String?
    var user_name: String?
    var user_surname: String?
    var address_district: String?
    var address_city: String?
    var address_country: String?
    var user_full_address: String?
}

struct UnionSignupRequest: Encodable {
    var method: String?
    var union_name: String?
    var union_tel: String?
    var union_email: String?
    var union_web_site: String?
    var union_password: String?
}
