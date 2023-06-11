//
//  IbanOptions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 10.06.2023.
//

import Foundation

enum IbanOptions: Int, CaseIterable {
    case create = 0
    case update = 1
    case delete = 2

    var description: String {
        switch self {
        case .create:
            return "Oluştur"
        case .update:
            return "Güncelle"
        case .delete:
            return "Sil"
        }
    }
}
