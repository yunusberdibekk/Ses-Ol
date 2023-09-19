//
//  AuthError.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation

enum AuthError: Error {
    case networkError(description: String)
    case authError(description: String)

    var description: String {
        switch self {
        case .networkError(let description):
            return "Network error: \(description)"

        case .authError(let description):
            return "Auth error: \(description)"

        }
    }
}
