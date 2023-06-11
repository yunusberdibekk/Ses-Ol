//
//  SupportRequestModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import Foundation

// MARK: - SupportRequestResponseElement
struct ProvidingAssistanceResponseElement: Codable {
    let assistanceID: Int?
    let assistanceTitle: String?
    let assistanceSentUnionID: Int?
    let assistanceSentUnionName: String?
    let assistanceUserAccountID: Int?
    let userTel: String?
    let assistanceNumOfPerson, assistanceCategoryID: Int?
    let assistanceCategoryName: String?
    let asistanceStatus: Int?
    let assistanceDescription, fullname: String?
    let addressID: Int?
    let addressDistrict, addressCity, addressCountry, fullAddress: String?
    let assistanceStatus: Int?

    enum CodingKeys: String, CodingKey {
        case assistanceID = "assistance_id"
        case assistanceTitle = "assistance_title"
        case assistanceSentUnionID = "assistance_sent_union_id"
        case assistanceSentUnionName = "assistance_sent_union_name"
        case assistanceUserAccountID = "assistance_user_account_id"
        case userTel = "user_tel"
        case assistanceNumOfPerson = "assistance_num_of_person"
        case assistanceCategoryID = "assistance_category_id"
        case assistanceCategoryName = "assistance_category_name"
        case asistanceStatus = "asistance_status"
        case assistanceDescription = "assistance_description"
        case fullname
        case addressID = "address_id"
        case addressDistrict = "address_district"
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case fullAddress = "full_address"
        case assistanceStatus = "assistance_status"
    }
}

typealias ProvidingAssistanceResponse = [ProvidingAssistanceResponseElement]

struct ProvidingAssistanceRequest: Encodable {
    let method: String?
    let user_assistance_account_id: Int?
    let is_a_union: Int?
}
// MARK: - VoluntarilyTransporterResponseElement
struct VoluntarilyTransporterResponseElement: Codable {
    let voluntarilyAccountID: Int?
    let userName, userSurname, userTel: String?
    let unionID: Int?
    let unionName, voluntarilyFromLocation, voluntarilyToLocation: String?
    let voluntarilyNumDriver, voluntarilyNumVehicle: Int?
    let voluntarilyDEC: String?
    let addressID: Int?
    let addressDistrict, addressCity, addressCountry, fullAddress: String?
    let voluntarilyApproveStatus: Int?

    enum CodingKeys: String, CodingKey {
        case voluntarilyAccountID = "voluntarily_account_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case userTel = "user_tel"
        case unionID = "union_id"
        case unionName = "union_name"
        case voluntarilyFromLocation = "voluntarily_from_location"
        case voluntarilyToLocation = "voluntarily_to_location"
        case voluntarilyNumDriver = "voluntarily_num_driver"
        case voluntarilyNumVehicle = "voluntarily_num_vehicle"
        case voluntarilyDEC = "voluntarily_dec"
        case addressID = "address_id"
        case addressDistrict = "address_district"
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case fullAddress = "full_address"
        case voluntarilyApproveStatus = "voluntarily_approve_status"
    }
}

typealias VoluntarilyTransporterResponse = [VoluntarilyTransporterResponseElement]

// MARK: - VoluntarilyPitchTentResponseElement
struct VoluntarilyPitchTentResponseElement: Codable {
    let voluntarilyAccountID: Int?
    let userName, userSurname: String?
    let unionID: Int?
    let unionName, userTel: String?
    let voluntarilyVehicleStatus: Int?
    let voluntarilyDesc: String?
    let addressID: Int?
    let addressDistrict, addressCity, addressCountry, fullAddress: String?
    let voluntarilyApproveStatus: Int?

    enum CodingKeys: String, CodingKey {
        case voluntarilyAccountID = "voluntarily_account_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case unionID = "union_id"
        case unionName = "union_name"
        case userTel = "user_tel"
        case voluntarilyVehicleStatus = "voluntarily_vehicle_status"
        case voluntarilyDesc = "voluntarily_desc"
        case addressID = "address_id"
        case addressDistrict = "address_district"
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case fullAddress = "full_address"
        case voluntarilyApproveStatus = "voluntarily_approve_status"
    }
}

typealias VoluntarilyPitchTentResponse = [VoluntarilyPitchTentResponseElement]


// MARK: - VoluntarilyPsychologistResponseElement
struct VoluntarilyPsychologistResponseElement: Codable {
    let voluntarilyAccountID: Int?
    let userName, userSurname: String?
    let unionID: Int?
    let unionName, userTel: String?
    let voluntarilyVehicleStatus: Int?
    let voluntarilyDesc: String?
    let addressID: Int?
    let addressDistrict, addressCity, addressCountry, fullAddress: String?
    let voluntarilyApproveStatus: Int?

    enum CodingKeys: String, CodingKey {
        case voluntarilyAccountID = "voluntarily_account_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case unionID = "union_id"
        case unionName = "union_name"
        case userTel = "user_tel"
        case voluntarilyVehicleStatus = "voluntarily_vehicle_status"
        case voluntarilyDesc = "voluntarily_desc"
        case addressID = "address_id"
        case addressDistrict = "address_district"
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case fullAddress = "full_address"
        case voluntarilyApproveStatus = "voluntarily_approve_status"
    }
}

typealias VoluntarilyPsychologistResponse = [VoluntarilyPsychologistResponseElement]

struct VoluntarilyPitchTentRequest: Encodable {
    let method: String?
    let user_account_id:Int?
    let is_a_union: Int?
}

struct VoluntarilyPsychologistRequest: Encodable {
    let method: String?
    let user_account_id:Int?
    let is_a_union: Int?
}

struct VoluntarilyTransporterRequest: Encodable {
    let method: String?
    let user_account_id:Int?
    let is_a_union: Int?
}
