//
//  DetailViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import Foundation


// MARK: - UpdateRequestReponse
struct UpdateRequestReponse: Codable {
    var status, msg: String?
}

// MARK: - UpdateRequest
struct UpdateRequest: Encodable {
    let method: String?
    let request_id: Int?
    let request_status: Int?
    let is_a_union: Int?
}

struct UpdateSupportRequestReponse: Codable {
    var status, msg: String?
}

struct UpdateSupportRequest: Encodable {
    let method: String?
    let assistance_id: Int?
    let assistance_status: Int?
}

struct DeletePostResponse: Codable {
    var status, msg: String?
}

struct DeletePostRequest: Encodable {
    let method: String?
    let post_id: Int?
}


struct DeleteSupportRequestResponse: Codable {
    var status, msg: String?
}

struct DeleteSupportRequest: Encodable {
    let method: String?
    let assistance_id: Int?
}

struct DeleteHelpRequestResponse: Codable {
    var status, msg: String?
}

struct DeleteHelpRequest: Encodable {
    let method: String?
    let request_id: Int?
}

struct DeleteVoluntarilyResponse: Codable {
    var status, msg: String?
}

struct DeleteVoluntarilyRequest: Encodable {
    let method: String?
    let user_account_id: Int?
}

struct UpdateVoluntarilyPsychologistRequest: Encodable {
    let method: String?
    let user_account_id: Int?
    let voluntarily_approve_status: Int?
}

struct UpdateVoluntarilyPsychologistResponse: Codable {
    var status, msg: String?
}

struct UpdateVoluntarilyPitchTentRequest: Encodable {
    let method: String?
    let user_account_id: Int?
    let voluntarily_approve_status: Int?
}

struct UpdateVoluntarilyPitchTentResponse: Codable {
    var status, msg: String?
}

struct UpdateVoluntarilyTransporterRequest: Encodable {
    let method: String?
    let user_account_id: Int?
    let voluntarily_approve_status: Int?
}

struct UpdateVoluntarilyTransporterResponse: Codable {
    var status, msg: String?
}
