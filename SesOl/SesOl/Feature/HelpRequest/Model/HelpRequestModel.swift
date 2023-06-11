//
//  HelpRequestsModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import Foundation

// MARK: - HelpRequestResponseElement
struct HelpRequestResponseElement: Codable {
    let requestID, requestAccountID: Int?
    let userName, userSurname, userTel: String?
    let requestUnionID: Int?
    let requestUnionName: String?
    let requestDisasterID: Int?
    let requestDisasterName: String?
    let requestCategoryID: Int?
    let requestCategoryName: String?
    let requestNumOfPerson: Int?
    let requestDesc: String?
    let requestAddressID: Int?
    let requestDistrict, requestCity, requestCountry, requestFullAddress: String?
    let requestApproveStatus: Int?
    
    enum CodingKeys: String, CodingKey {
        case requestID = "request_id"
        case requestAccountID = "request_account_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case userTel = "user_tel"
        case requestUnionID = "request_union_id"
        case requestUnionName = "request_union_name"
        case requestDisasterID = "request_disaster_id"
        case requestDisasterName = "request_disaster_name"
        case requestCategoryID = "request_category_id"
        case requestCategoryName = "request_category_name"
        case requestNumOfPerson = "request_num_of_person"
        case requestDesc = "request_desc"
        case requestAddressID = "request_address_id"
        case requestDistrict = "request_district"
        case requestCity = "request_city"
        case requestCountry = "request_country"
        case requestFullAddress = "request_full_address"
        case requestApproveStatus = "request_approve_status"
    }
}

typealias HelpRequestResponse = [HelpRequestResponseElement]

// MARK: - HelpRequest
struct HelpRequest: Encodable {
    let method: String?
    let request_account_id:Int?
    let is_a_union: Int?
}


