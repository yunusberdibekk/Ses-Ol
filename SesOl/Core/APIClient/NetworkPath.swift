//
//  NetworkPath.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 6.06.2023.
//

import Foundation

enum NetworkPath: String {
    case login = "LoginRequest.php?"
    case unionsCrud = "Unions_CRUD.php?"
    case unionPostCrud = "UnionPost_CRUD.php?"
    case requestCrud = "Request_CRUD.php?"
    case usersCrud = "Users_CRUD.php?"
    case providingAssistanceCrud = "ProvidingAssistance_CRUD.php?"
    case getDisaster = "getDisaster.php"
    case getLocationInfo = "getLocationInfo.php"
    case ibanCrud = "Iban_CRUD.php?"
    case getRequirement = "getRequirement.php"
    case voluntarilyTransporter = "VoluntarilyTransporter_CRUD.php?"
    case voluntarilyPsychologist = "VoluntarilyPsychologist_CRUD.php?"
    case voluntarilyPitchTent = "VoluntarilyPitchTent_CRUD.php?"

    static let baseURL: String = "http://localhost/ses_ol_api/api/"
}
