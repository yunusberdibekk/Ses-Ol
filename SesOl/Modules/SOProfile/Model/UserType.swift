//
//  UserTyoe.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

enum UserType: Int, CaseIterable, Hashable {
    case citizien = 0
    case union = 1

    var description: String {
        switch self {
        case .citizien:
            "Citizien"
        case .union:
            "Union"
        }
    }
}
