//
//  SupportRequestOption.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.06.2023.
//

import Foundation

enum RequestOptions: Int, CaseIterable {
    case waiting = 0
    case rejected = 1
    case approved = 2

    var description: String {
        switch self {
        case .waiting:
            return "Bekleyen"
        case .rejected:
            return "Reddedilen"
        case .approved:
            return "Onaylanan"
        }
    }
}
