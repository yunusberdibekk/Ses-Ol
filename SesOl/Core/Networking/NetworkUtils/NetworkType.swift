//
//  NetworkType.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation
import Alamofire

enum NetworkType {
    case get
    case post

    func toAF() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}

