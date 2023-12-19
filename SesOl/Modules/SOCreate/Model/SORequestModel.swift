//
//  SORequestModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.12.2023.
//

import Foundation

struct UnionRequest: Encodable {
    let method: String
}

struct CreateUserRequest: Encodable {
    let method: String
    let request_account_id: Int
    let num_of_person: Int
    let request_disaster_id: Int
    let request_union_id: Int
    let request_category: Int
    let request_desc: String
}

//struct CreateUnionRequest: Encodable {
//    let method: String
//    let request_account_id: Int
//    let num_of_person: Int
//    let request_disaster_id: Int
//    let request_category: Int
//    let request_desc: String
//}

struct CreateSupportRequest: Encodable {
    let method: String
    let user_assistance_account_id: Int
    let assistance_title: String
    let assistance_sent_union_id: Int
    let assistance_num_of_person: Int
    let assistance_category_id: Int
    let assistance_desc: String
    let assistance_address_id: Int
    let is_a_union: Int
}

struct CreatePostRequest: Encodable {
    let method: String
    let post_publisher_id: Int
    let post_content: String
}

struct CreateVoluntarilyPsychologistRequest: Encodable {
    let method: String
    let user_account_id: Int
    let voluntarily_union_id: Int
    let voluntarily_vehicle_status: Int
    let voluntarily_desc: String
}

struct CreateVoluntarilyPitchTentRequest: Encodable {
    let method: String
    let user_account_id: Int
    let voluntarily_union_id: Int
    let voluntarily_vehicle_status: Int
    let voluntarily_description: String
}

struct CreateVoluntarilyTransporterRequest: Encodable {
    let method: String
    let user_account_id: Int
    let union_id: Int
    let voluntarily_from_location: String
    let voluntarily_to_location: String
    let voluntarily_num_of_vehicle: Int
    let voluntarily_num_of_driver: Int
    let voluntarily_description: String
}
