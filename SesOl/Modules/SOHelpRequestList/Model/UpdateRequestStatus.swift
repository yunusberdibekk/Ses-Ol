//
//  RequestStatus.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.12.2023.
//

import Foundation

enum UpdateRequestStatus: Int {
    case reject = 0
    case approve = 1

    var desc: String {
        switch self {
        case .reject:
            "Reject"
        case .approve:
            "Approve"
        }
    }
}
