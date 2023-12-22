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

    static let mockUnionResponseElement1: UnionResponseElement = .init(id: 1, unionName: "AFAD")
    static let mockUnionResponseElement2: UnionResponseElement = .init(id: 2, unionName: "KIZILAY")
    static let mockUnionResponseElement3: UnionResponseElement = .init(id: 3, unionName: "AHBAP")
    static let mockUnionResponseElements: UnionResponse = [
        mockUnionResponseElement1,
        mockUnionResponseElement2,
        mockUnionResponseElement3
    ]
}

typealias UnionResponse = [UnionResponseElement]

struct HelpRequestCategoryResponseElement: Codable, Hashable {
    let categoryID: Int
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }

    static let mockHelpRequestCategoryResponseElement1: HelpRequestCategoryResponseElement = .init(categoryID: 1, categoryName: "Aşevi")
    static let mockHelpRequestCategoryResponseElement2: HelpRequestCategoryResponseElement = .init(categoryID: 2, categoryName: "Giyim")
    static let mockHelpRequestCategoryResponseElement3: HelpRequestCategoryResponseElement = .init(categoryID: 3, categoryName: "Gıda")
    static let mockHelpRequestCategoryResponseElement4: HelpRequestCategoryResponseElement = .init(categoryID: 4, categoryName: "Hijyen")
    static let mockHelpRequestCategoriesElements: HelpRequestCategoriesResponse = [
        .mockHelpRequestCategoryResponseElement1,
        .mockHelpRequestCategoryResponseElement2,
        .mockHelpRequestCategoryResponseElement3,
        .mockHelpRequestCategoryResponseElement4
    ]
}

typealias HelpRequestCategoriesResponse = [HelpRequestCategoryResponseElement]

struct DisasterResponseElement: Codable, Hashable {
    let disasterID: Int
    let disasterName: String

    enum CodingKeys: String, CodingKey {
        case disasterID = "disaster_id"
        case disasterName = "disaster_name"
    }

    static let mockDisasterResponseElement1: DisasterResponseElement = .init(disasterID: 1, disasterName: "Deprem")
    static let mockDisasterResponseElement2: DisasterResponseElement = .init(disasterID: 1, disasterName: "Yangın")
    static let mockDisasterResponseElement3: DisasterResponseElement = .init(disasterID: 1, disasterName: "Toprak Kayması")
    static let mockDisasterResponseElement4: DisasterResponseElement = .init(disasterID: 1, disasterName: "Fırtına")
    static let mockDisasterResponseElement5: DisasterResponseElement = .init(disasterID: 1, disasterName: "Çığ")
    static let mockDisasterResponseElements: DisasterResponse = [
        .mockDisasterResponseElement1,
        .mockDisasterResponseElement2,
        .mockDisasterResponseElement3,
        .mockDisasterResponseElement4,
        .mockDisasterResponseElement5
    ]
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
