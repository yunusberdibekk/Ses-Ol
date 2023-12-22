//
//  SupportRequestModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import Foundation

struct ProvidingAssistanceResponseElement: Codable {
    let assistanceID: Int
    let assistanceTitle: String
    let assistanceSentUnionID: Int
    let assistanceSentUnionName: String
    let assistanceUserAccountID: Int
    let userTel: String
    let assistanceNumOfPerson, assistanceCategoryID: Int
    let assistanceCategoryName: String
    let asistanceStatus: Int
    let assistanceDescription, fullname: String
    let addressID: Int
    let addressDistrict, addressCity, addressCountry, fullAddress: String
    let assistanceStatus: Int

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

    static let mockStandartSupportRequestResponseElement1: ProvidingAssistanceResponseElement = .init(
        assistanceID: 2,
        assistanceTitle: "Standart Request 2",
        assistanceSentUnionID: UnionResponseElement.mockUnionResponseElement1.id,
        assistanceSentUnionName: UnionResponseElement.mockUnionResponseElement1.unionName,
        assistanceUserAccountID: LoginResponse.mockCitizienLoginResponse.userAccountID,
        userTel: "+904143658490",
        assistanceNumOfPerson: 10,
        assistanceCategoryID: HelpRequestCategoryResponseElement.mockHelpRequestCategoryResponseElement1.categoryID,
        assistanceCategoryName: HelpRequestCategoryResponseElement
            .mockHelpRequestCategoryResponseElement1.categoryName,
        asistanceStatus: -1,
        assistanceDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu ultrices vitae auctor eu.",
        fullname: "Reyes Stephie",
        addressID: 1,
        addressDistrict: District.mockDistrict1.ilceAdi,
        addressCity: City.mockCity1.sehirAdi,
        addressCountry: Country.mockCountry1.ulkeAdi,
        fullAddress: "",
        assistanceStatus: 1)

    static let mockStandartSupportRequestResponseElement2: ProvidingAssistanceResponseElement = .init(
        assistanceID: 2,
        assistanceTitle: "Standart Request 2",
        assistanceSentUnionID: UnionResponseElement.mockUnionResponseElement2.id,
        assistanceSentUnionName: UnionResponseElement.mockUnionResponseElement2.unionName,
        assistanceUserAccountID: LoginResponse.mockCitizienLoginResponse.userAccountID,
        userTel: "+902665841155",
        assistanceNumOfPerson: 9,
        assistanceCategoryID: HelpRequestCategoryResponseElement.mockHelpRequestCategoryResponseElement1.categoryID,
        assistanceCategoryName: HelpRequestCategoryResponseElement
            .mockHelpRequestCategoryResponseElement1.categoryName,
        asistanceStatus: -1,
        assistanceDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Senectus et netus et malesuada fames ac turpis egestas integer. Urna et pharetra pharetra massa massa ultricies.",
        fullname: "Reyes Stephie",
        addressID: 1,
        addressDistrict: District.mockDistrict2.ilceAdi,
        addressCity: City.mockCity1.sehirAdi,
        addressCountry: Country.mockCountry1.ulkeAdi,
        fullAddress: "",
        assistanceStatus: 1)
    static let mockStandartSupportRequestResponseElements: ProvidingAssistanceResponse = [.mockStandartSupportRequestResponseElement1, .mockStandartSupportRequestResponseElement2]
}

typealias ProvidingAssistanceResponse = [ProvidingAssistanceResponseElement]

struct ProvidingAssistanceRequest: Encodable {
    let method: String
    let user_assistance_account_id: Int
    let is_a_union: Int
}

struct VoluntarilyTransporterResponseElement: Codable {
    let voluntarilyAccountID: Int
    let userName, userSurname, userTel: String
    let unionID: Int
    let unionName, voluntarilyFromLocation, voluntarilyToLocation: String
    let voluntarilyNumDriver, voluntarilyNumVehicle: Int
    let voluntarilyDEC: String
    let addressID: Int
    let addressDistrict, addressCity, addressCountry, fullAddress: String
    let voluntarilyApproveStatus: Int

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

    static let mockTransporterSupportRequestResponseElement: VoluntarilyTransporterResponseElement = .init(
        voluntarilyAccountID: 1,
        userName: "Nguyen",
        userSurname: "Sharlene",
        userTel: "+902627989609",
        unionID: UnionResponseElement.mockUnionResponseElement3.id,
        unionName: UnionResponseElement.mockUnionResponseElement3.unionName,
        voluntarilyFromLocation: "Ankara",
        voluntarilyToLocation: "İstanbul",
        voluntarilyNumDriver: 10,
        voluntarilyNumVehicle: 12,
        voluntarilyDEC: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quam pellentesque nec nam aliquam sem.",
        addressID: 1,
        addressDistrict: District.mockDistrict1.ilceAdi,
        addressCity: City.mockCity1.sehirAdi,
        addressCountry: Country.mockCountry1.ulkeAdi,
        fullAddress: "",
        voluntarilyApproveStatus: -1)
}

typealias VoluntarilyTransporterResponse = [VoluntarilyTransporterResponseElement]

struct VoluntarilyPitchTentResponseElement: Codable {
    let voluntarilyAccountID: Int
    let userName, userSurname: String
    let unionID: Int
    let unionName, userTel: String
    let voluntarilyVehicleStatus: Int
    let voluntarilyDesc: String
    let addressID: Int
    let addressDistrict, addressCity, addressCountry, fullAddress: String
    let voluntarilyApproveStatus: Int

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

    static let mockPitchTentSupportRequestResponseElement: VoluntarilyPitchTentResponseElement = .init(
        voluntarilyAccountID: LoginResponse.mockCitizienLoginResponse.userAccountID,
        userName: "Smith",
        userSurname: "Andrea",
        unionID: UnionResponseElement.mockUnionResponseElement3.id,
        unionName: UnionResponseElement.mockUnionResponseElement3.unionName,
        userTel: "+905103267014",
        voluntarilyVehicleStatus: 0,
        voluntarilyDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Libero enim sed faucibus turpis in eu.",
        addressID: 1,
        addressDistrict: District.mockDistrict1.ilceAdi,
        addressCity: City.mockCity1.sehirAdi,
        addressCountry: Country.mockCountry1.ulkeAdi,
        fullAddress: "",
        voluntarilyApproveStatus: 1)
}

typealias VoluntarilyPitchTentResponse = [VoluntarilyPitchTentResponseElement]

struct VoluntarilyPsychologistResponseElement: Codable {
    let voluntarilyAccountID: Int
    let userName, userSurname: String
    let unionID: Int
    let unionName, userTel: String
    let voluntarilyVehicleStatus: Int
    let voluntarilyDesc: String
    let addressID: Int
    let addressDistrict, addressCity, addressCountry, fullAddress: String
    let voluntarilyApproveStatus: Int

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

    static let mockPsychologistSupportRequestResponseElement: VoluntarilyPsychologistResponseElement = .init(
        voluntarilyAccountID: 1,
        userName: "Jackson",
        userSurname: "Matthew",
        unionID: UnionResponseElement.mockUnionResponseElement2.id,
        unionName: UnionResponseElement.mockUnionResponseElement2.unionName,
        userTel: "+903582330550",
        voluntarilyVehicleStatus: 1,
        voluntarilyDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In nisl nisi scelerisque eu ultrices vitae auctor eu.",
        addressID: 1,
        addressDistrict: District.mockDistrict3.ilceAdi,
        addressCity: City.mockCity2.sehirAdi,
        addressCountry: Country.mockCountry1.ulkeAdi,
        fullAddress: "Full adress",
        voluntarilyApproveStatus: 1)
}

typealias VoluntarilyPsychologistResponse = [VoluntarilyPsychologistResponseElement]

struct VoluntarilyPitchTentRequest: Encodable {
    let method: String
    let user_account_id: Int
    let is_a_union: Int
}

struct VoluntarilyPsychologistRequest: Encodable {
    let method: String
    let user_account_id: Int
    let is_a_union: Int
}

struct VoluntarilyTransporterRequest: Encodable {
    let method: String
    let user_account_id: Int
    let is_a_union: Int
}
