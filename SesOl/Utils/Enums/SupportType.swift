//
//  SupportType.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.06.2023.
//

import Foundation

enum SupportType: Int, CaseIterable {
    case providingAssistance = 0
    case psychologist = 1
    case pitchTent = 2
    case transporter = 3
    
    var description: String {
        switch self {
        case .providingAssistance:
            return "Diğer"
        case .psychologist:
            return "Psikolog"
        case .pitchTent:
            return "Çadır Kurma"
        case .transporter:
            return "Taşıt Desteği"
        }
    }
}
