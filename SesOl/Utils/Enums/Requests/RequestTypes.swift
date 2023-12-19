//
//  RequestTypes.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.12.2023.
//

import Foundation

enum RequestTypes: CaseIterable, Hashable {
    case help
    case support

    var title: String {
        switch self {
        case .help:
            "Yardım Talebi"
        case .support:
            "Destek Talebi"
        }
    }
}
