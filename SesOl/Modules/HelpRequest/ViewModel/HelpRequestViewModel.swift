//
//  HelpRequestsViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import Foundation

final class HelpRequestViewModel: ObservableObject {
    /// Readed userID value in UserDefaults
    @Published var userID = -1
    /// Readed isUnionAccount value in UserDefaults
    @Published var isUnionAccount = -1
    @Published var selectedOption: RequestOptions = .waiting

    @Published var approvedHelpRequests: HelpRequestResponse?
    @Published var waitingHelpRequests: HelpRequestResponse?
    @Published var rejectedHelpRequests: HelpRequestResponse?
    
    @Published var error: Bool = false
    @Published var errorMessage: NetworkError?

    @Published var systemRequestMessage = HelpRequestResponseElement(requestID: -1, requestAccountID: -1, userName: "System", userSurname: "", userTel: "system", requestUnionID: -1, requestUnionName: "", requestDisasterID: -1, requestDisasterName: "", requestCategoryID: -1, requestCategoryName: "", requestNumOfPerson: -1, requestDesc: "Şu anda kayıtlı veri bulunmamaktadır.", requestAddressID: -1, requestDistrict: "", requestCity: "", requestCountry: "", requestFullAddress: "", requestApproveStatus: -1)

    private let cache = UserDefaultCache()

    func getApprovedHelpRequests() async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: HelpRequest(method: RequestMethods.read_request_approved.rawValue, request_account_id: userID, is_a_union: isUnionAccount), type: HelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.approvedHelpRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getWaitingHelpRequests() async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: HelpRequest(method: RequestMethods.read_request_waiting.rawValue, request_account_id: userID, is_a_union: isUnionAccount), type: HelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.waitingHelpRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getRejectedHelpRequests() async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: HelpRequest(method: RequestMethods.read_request_rejected.rawValue, request_account_id: userID, is_a_union: isUnionAccount), type: HelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.rejectedHelpRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func readCache(userIdKey: UserCacheKeys, isUnionKey: UserCacheKeys) {
        let userID = readUserCache(key: userIdKey)
        let isUnionAccount = readUserCache(key: isUnionKey)

        DispatchQueue.main.async {
            self.userID = userID
            self.isUnionAccount = isUnionAccount
        }
    }
    
    private func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}
