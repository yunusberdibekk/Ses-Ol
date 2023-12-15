//
//  IbanOptions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 15.12.2023.
//

import Foundation

enum IbanOptions: CaseIterable {
    case create
    case update
    case delete

    var description: String {
        switch self {
        case .create:
            "Create"
        case .update:
            "Update"
        case .delete:
            "Delete"
        }
    }
}
