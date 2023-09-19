//
//  PostError.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation

enum NetworkError: Error {
    case networkError(description: String)

    var networkError: String {
        switch self {
        case .networkError(let description):
            return "Network error: \(description)"
        }
    }
}
