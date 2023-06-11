//
//  RequestMethods.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.06.2023.
//

import Foundation

enum RequestMethods: String {
    case create_iban = "create_iban"
    case read_iban = "read_iban"
    case update_iban = "update_iban"
    case delete_iban = "delete_iban"
    case create_assistance = "create_assistance"
    case read_my_assistance = "read_my_assistance"
    case read_waiting_providing = "read_waiting_providing"
    case read_approved_providing = "read_approved_providing"
    case read_rejected_providing = "read_rejected_providing"
    case delete_my_assistance = "delete_my_assistance"
    case read_assistance = "read_assistance"
    case update_my_assistance = "update_my_assistance"
    case read_request_approved = "read_request_approved"
    case read_request_waiting = "read_request_waiting"
    case read_request_rejected = "read_request_rejected"
    case update_request_status = "update_request_status"
    case create_request = "create_request"
    case create_request_as_union = "create_request_as_union"
    case delete_request = "delete_request"
    case create_post = "create_post"
    case read_post = "read_post"
    case delete_post = "delete_post"
    case create = "create"
    case read_union = "read_union"
    case get_all_unions = "get_all_unions"
    case create_user = "create_user"
    case read_user = "read_user"
    case create_voluntarily = "create_voluntarily"
    case update_voluntarily = "update_voluntarily"
    case delete_volantarily = "delete_voluntarily"
}
