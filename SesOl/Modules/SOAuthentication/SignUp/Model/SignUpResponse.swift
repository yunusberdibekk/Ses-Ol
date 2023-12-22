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

    static let mockCountry1: Country = .init(id: UUID().uuidString, ulkeID: "1", ulkeAdi: "Türkiye")
    static let mockCountriesResponse: [Country] = [.mockCountry1]
}

struct City: Identifiable, Hashable, Equatable {
    let id: String
    let sehirID: String
    let sehirAdi: String
    let ulkeIDFK: String

    static let mockCity1: City = .init(id: UUID().uuidString, sehirID: "1", sehirAdi: "Adana", ulkeIDFK: "1")
    static let mockCity2: City = .init(id: UUID().uuidString, sehirID: "2", sehirAdi: "Adıyaman", ulkeIDFK: "1")
    static let mockCity3: City = .init(id: UUID().uuidString, sehirID: "3", sehirAdi: "Afyonkarahisar", ulkeIDFK: "1")
    static let mockCity4: City = .init(id: UUID().uuidString, sehirID: "4", sehirAdi: "Ağrı", ulkeIDFK: "1")
    static let mockCity5: City = .init(id: UUID().uuidString, sehirID: "5", sehirAdi: "Aksaray", ulkeIDFK: "1")
    static let mockCity6: City = .init(id: UUID().uuidString, sehirID: "6", sehirAdi: "Amasya", ulkeIDFK: "1")
    static let mockCity7: City = .init(id: UUID().uuidString, sehirID: "7", sehirAdi: "Ankara", ulkeIDFK: "1")
    static let mockCity8: City = .init(id: UUID().uuidString, sehirID: "8", sehirAdi: "Antalya", ulkeIDFK: "1")
    static let mockCity9: City = .init(id: UUID().uuidString, sehirID: "9", sehirAdi: "Ardahan", ulkeIDFK: "1")

    static let mockCitiesResponse: [City] = [
        .mockCity1,
        .mockCity2,
        .mockCity3,
        .mockCity4,
        .mockCity5,
        .mockCity6,
        .mockCity7,
        .mockCity8,
        .mockCity9,
    ]
}

struct District: Identifiable, Hashable, Equatable {
    let id: String
    let ilceID: String
    let ilceAdi: String
    let sehirIDFK: String

    static let mockDistrict1: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Aladağ", sehirIDFK: "1")
    static let mockDistrict2: District = .init(id: UUID().uuidString, ilceID: "2", ilceAdi: "Ceyhan", sehirIDFK: "1")
    static let mockDistrict3: District = .init(id: UUID().uuidString, ilceID: "3", ilceAdi: "Çukurova", sehirIDFK: "1")
    static let mockDistrict4: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Besni", sehirIDFK: "2")
    static let mockDistrict5: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Çelikhan", sehirIDFK: "2")
    static let mockDistrict6: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Gerger", sehirIDFK: "2")
    static let mockDistrict7: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Başmakçı", sehirIDFK: "3")
    static let mockDistrict8: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Bayat", sehirIDFK: "3")
    static let mockDistrict9: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Diyadin", sehirIDFK: "4")
    static let mockDistrict10: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Doğubayazıt", sehirIDFK: "4")
    static let mockDistrict11: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Ağaçören", sehirIDFK: "5")
    static let mockDistrict12: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Eskil", sehirIDFK: "5")
    static let mockDistrict13: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Gülağaç", sehirIDFK: "5")
    static let mockDistrict14: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Göynücek", sehirIDFK: "6")
    static let mockDistrict15: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Gümüşhacıköy", sehirIDFK: "6")
    static let mockDistrict16: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Hamamözü", sehirIDFK: "6")
    static let mockDistrict17: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Akyurt", sehirIDFK: "7")
    static let mockDistrict18: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Altındağ", sehirIDFK: "7")
    static let mockDistrict19: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Ayaş", sehirIDFK: "7")
    static let mockDistrict20: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Akseki", sehirIDFK: "8")
    static let mockDistrict21: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Aksu", sehirIDFK: "8")
    static let mockDistrict22: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Alanya", sehirIDFK: "8")
    static let mockDistrict23: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Çıldır", sehirIDFK: "9")
    static let mockDistrict24: District = .init(id: UUID().uuidString, ilceID: "1", ilceAdi: "Damal", sehirIDFK: "9")

    static let mockDistrictsResponse: [District] = [
        .mockDistrict1,
        .mockDistrict2,
        .mockDistrict3,
        .mockDistrict4,
        .mockDistrict5,
        .mockDistrict6,
        .mockDistrict7,
        .mockDistrict8,
        .mockDistrict9,
        .mockDistrict10,
        .mockDistrict11,
        .mockDistrict12,
        .mockDistrict13,
        .mockDistrict14,
        .mockDistrict15,
        .mockDistrict16,
        .mockDistrict17,
        .mockDistrict18,
        .mockDistrict19,
        .mockDistrict20,
        .mockDistrict21,
        .mockDistrict22,
        .mockDistrict23,
        .mockDistrict24,
    ]
}
