//
//  SOHelpRequestListViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import Foundation
import SwiftUI

final class SOHelpRequestListViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID: Int = 0

    @Published var selectedRequestStatus: RequestStatus = .waiting
    @Published var approvedHelpRequests: HelpRequestResponse = []
    @Published var waitingHelpRequests: HelpRequestResponse = []
    @Published var rejectedHelpRequests: HelpRequestResponse = []
    @Published var logMessage: String = ""
    @Published var logStatus: Bool = false

    func getApprovedHelpRequests() async {
        let response = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: HelpRequest(
                method: RequestMethods.read_request_approved.rawValue,
                request_account_id: userID,
                is_a_union: userType.rawValue),
            type: HelpRequestResponse.self)
        switch response {
        case .success(let success):
            DispatchQueue.main.async {
                self.approvedHelpRequests = success
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getWaitingHelpRequests() async {
        let response = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: HelpRequest(
                method: RequestMethods.read_request_waiting.rawValue,
                request_account_id: userID,
                is_a_union: userType.rawValue),
            type: HelpRequestResponse.self)
        switch response {
        case .success(let success):
            DispatchQueue.main.async {
                self.waitingHelpRequests = success
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getRejectedHelpRequests() async {
        let response = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: HelpRequest(
                method: RequestMethods.read_request_rejected.rawValue,
                request_account_id: userID,
                is_a_union: userType.rawValue),
            type: HelpRequestResponse.self)
        switch response {
        case .success(let success):
            DispatchQueue.main.async {
                self.rejectedHelpRequests = success
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func changeRequestStatus(
        status: UpdateRequestStatus, request: HelpRequestResponseElement, index: Int) async
    {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: UpdateRequest(
                method: RequestMethods.update_request_status.rawValue,
                request_id: request.requestID,
                request_status: status.rawValue,
                is_a_union: userType.rawValue),
            type: UpdateRequestReponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await updateRequestList(status, at: index, with: request)
                await showMessage(message: "Güncelleme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func deleteHelpRequest(requestID: Int, index: Int) async {
        guard userType == .citizien else { return }
        let response = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: DeleteHelpRequest(
                method: RequestMethods.delete_request.rawValue,
                request_id: requestID),
            type: DeleteHelpRequestResponse.self)

        switch response {
        case .success(let model):
            if model.status == "ok" {
                await deleteRequestAtList(index)
                await showMessage(message: "Silme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    @MainActor
    private func showMessage(message: String) {
        logMessage = message
        logStatus.toggle()
    }

    @MainActor
    private func updateRequestList(
        _ status: UpdateRequestStatus, at index: Int, with request: HelpRequestResponseElement)
    {
        switch selectedRequestStatus {
        case .waiting:
            if status == .reject {
                waitingHelpRequests.remove(at: index)
                rejectedHelpRequests.append(request)
            } else {
                waitingHelpRequests.remove(at: index)
                approvedHelpRequests.append(request)
            }
        case .rejected:
            if status == .approve {
                rejectedHelpRequests.remove(at: index)
                approvedHelpRequests.append(request)
            }
        case .approved:
            if status == .reject {
                approvedHelpRequests.remove(at: index)
                rejectedHelpRequests.append(request)
            }
        }
    }

    @MainActor
    private func deleteRequestAtList(_ index: Int) {
        switch selectedRequestStatus {
        case .waiting:
            waitingHelpRequests.remove(at: index)
        case .rejected:
            rejectedHelpRequests.remove(at: index)
        case .approved:
            approvedHelpRequests.remove(at: index)
        }
    }
}
