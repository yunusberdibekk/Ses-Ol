//
//  SignUpModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.04.2023.
//

import Foundation

// MARK: - LocationResponseElement
struct LocationResponseElement: Codable, Hashable {
    var ulkeID, ulkeAdi, sehirID, sehirAdi: String?
    var ulkeIDFk, ilceID, ilceAdi, sehirIDFk: String?

    enum CodingKeys: String, CodingKey {
        case ulkeID = "ulke_id"
        case ulkeAdi = "ulke_adi"
        case sehirID = "sehir_id"
        case sehirAdi = "sehir_adi"
        case ulkeIDFk = "ulke_id_fk"
        case ilceID = "ilce_id"
        case ilceAdi = "ilce_adi"
        case sehirIDFk = "sehir_id_fk"
    }
}

typealias LocationResponse = [[LocationResponseElement]]


// MARK: - CitizienSignupResponse
struct CitizienSignupResponse: Codable {
    var status, msg: String?
}

// MARK: - CitizienSignupRequest
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

// MARK: - UnionSignupResponse
struct UnionSignupResponse: Codable {
    var status, msg: String?
}

// MARK: - UnionSignupRequest
struct UnionSignupRequest: Encodable {
    var method: String?
    var union_name: String?
    var union_tel: String?
    var union_email: String?
    var union_web_site: String?
    var union_password: String?
}


struct Country: Hashable {
    let ulke_id: String
    let ulke_adi: String
}

struct City: Hashable {
    let sehir_id: String
    let sehir_adi: String
    let ulke_idfk: String
}

struct District: Hashable {
    let ilce_id: String
    let ilce_adi: String
    let sehir_idfk: String
}
