//
//  SOResponseModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.12.2023.
//

import Foundation

struct UnionResponseElement: Codable, Hashable, Identifiable {
    let id: Int
    let unionName: String

    enum CodingKeys: String, CodingKey {
        case id = "union_id"
        case unionName = "union_name"
    }
}

typealias UnionResponse = [UnionResponseElement]

struct HelpRequestCategoryResponseElement: Codable, Hashable {
    let categoryID: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

typealias HelpRequestCategoriesResponse = [HelpRequestCategoryResponseElement]

struct DisasterResponseElement: Codable, Hashable {
    let disasterID: Int
    let disasterName: String

    enum CodingKeys: String, CodingKey {
        case disasterID = "disaster_id"
        case disasterName = "disaster_name"
    }
}

typealias DisasterResponse = [DisasterResponseElement]

struct CreateUnionHelpRequestResponse: Codable {
    let status, msg: String
}

struct CreateSupportRequestResponse: Codable {
    let status, msg: String
}

struct CreatePostResponse: Codable {
    let status, msg: String
}

struct CreateVoluntarilyPsychologistResponse: Codable {
    let status, msg: String
}

struct CreateVoluntarilyPitchTentResponse: Codable {
    let status, msg: String
}

struct CreateVoluntarilyTransporterResponse: Codable {
    let status, msg: String
}

struct CreateUserHelpRequestResponse: Codable {
    let status, msg: String
}
