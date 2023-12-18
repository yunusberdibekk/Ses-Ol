//
//  SigupResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.12.2023.
//

import Foundation

struct LocationResponseElement: Codable, Hashable {
    var ulkeID, ulkeAdi, sehirID, sehirAdi: String
    var ulkeIDFk, ilceID, ilceAdi, sehirIDFK: String

    enum CodingKeys: String, CodingKey {
        case ulkeID = "ulke_id"
        case ulkeAdi = "ulke_adi"
        case sehirID = "sehir_id"
        case sehirAdi = "sehir_adi"
        case ulkeIDFk = "ulke_id_fk"
        case ilceID = "ilce_id"
        case ilceAdi = "ilce_adi"
        case sehirIDFK = "sehir_id_fk"
    }
}

struct CitizienSignUpResponse: Codable {
    var status, msg: String
}

struct UnionSignUpResponse: Codable {
    var status, msg: String
}

struct Country: Identifiable, Hashable, Equatable {
    let id: String
    let ulkeID: String
    let ulkeAdi: String
}

struct City: Identifiable, Hashable, Equatable {
    let id: String
    let sehirID: String
    let sehirAdi: String
    let ulkeIDFK: String
}

struct District: Identifiable, Hashable, Equatable {
    let id: String
    let ilceID: String
    let ilceAdi: String
    let sehirIDFK: String
}
