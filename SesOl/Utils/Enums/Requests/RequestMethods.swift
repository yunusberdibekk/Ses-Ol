//
//  RequestMethods.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.06.2023.
//

import Foundation

enum RequestMethods: String {
    case create_iban
    case read_iban
    case update_iban
    case delete_iban
    case create_assistance
    case read_my_assistance
    case read_waiting_providing
    case read_approved_providing
    case read_rejected_providing
    case delete_my_assistance
    case read_assistance
    case update_my_assistance
    case read_request_approved
    case read_request_waiting
    case read_request_rejected
    case update_request_status
    case create_request
    case create_request_as_union
    case delete_request
    case create_post
    case read_post
    case delete_post
    case create
    case read_union
    case get_all_unions
    case create_user
    case read_user
    case create_voluntarily
    case update_voluntarily
    case delete_voluntarily
}
