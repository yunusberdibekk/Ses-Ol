//
//  RequestTypes.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.12.2023.
//

import Foundation

enum SupportRequestTypes: CaseIterable {
    case standart
    case psyhlogist
    case pitchtent
    case transporter

    var title: String {
        switch self {
        case .standart:
            "Standart Destek Talebi"
        case .psyhlogist:
            "Psikolojik Destek Talebi"
        case .pitchtent:
            "Çadır Kurma Destek Talebi"
        case .transporter:
            "Taşıma Destek Talebi"
        }
    }
}
