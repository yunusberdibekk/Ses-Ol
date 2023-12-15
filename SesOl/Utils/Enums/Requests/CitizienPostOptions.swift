//
//  CitizienPostOptions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 9.06.2023.
//

import Foundation

enum CitizienPostOptions: Int, CaseIterable {
    case helpRequest = 0
    case supportRequest = 1
    
    var description: String {
        switch self {
        case .helpRequest:
            return "Yardım Talebi"
        case .supportRequest:
            return "Destek Talebi"
        }
    }
}
