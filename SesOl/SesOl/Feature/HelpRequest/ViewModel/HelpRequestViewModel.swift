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
    
    @Published var approvedHelpRequests: HelpRequestResponse? = nil
    @Published var waitingHelpRequests: HelpRequestResponse? = nil
    @Published var rejectedHelpRequests: HelpRequestResponse? = nil
    
    @Published var systemRequestMessage = HelpRequestResponseElement(requestID: -1, requestAccountID: -1, userName: "System", userSurname: "", userTel: "system", requestUnionID: -1, requestUnionName: "", requestDisasterID: -1, requestDisasterName: "", requestCategoryID: -1, requestCategoryName: "", requestNumOfPerson: -1, requestDesc: "Şu anda kayıtlı veri bulunmamaktadır.", requestAddressID: -1, requestDistrict: "", requestCity: "", requestCountry: "", requestFullAddress: "", requestApproveStatus: -1)

   

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func getApprovedHelpRequests() async {
        let approvedRequests = await getAllHelpRequests(method: .read_request_approved, request_account_id: userID, is_a_union: isUnionAccount)

        DispatchQueue.main.async {
            self.approvedHelpRequests = approvedRequests
        }
    }

    func getWaitingHelpRequests() async {
        let waitingRequests = await getAllHelpRequests(method: .read_request_waiting, request_account_id: userID, is_a_union: isUnionAccount)

        DispatchQueue.main.async {
            self.waitingHelpRequests = waitingRequests
        }
    }

    func getRejectedHelpRequests() async {
        let rejectedRequests = await getAllHelpRequests(method: .read_request_rejected, request_account_id: userID, is_a_union: isUnionAccount)

        DispatchQueue.main.async {
            self.rejectedHelpRequests = rejectedRequests
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
}

extension HelpRequestViewModel: IHelpRequestViewModel {
    func getAllHelpRequests(method: RequestMethods, request_account_id: Int, is_a_union: Int) async -> HelpRequestResponse? {
        guard let response = await networkManager.post(path: .requestCrud, model: HelpRequest(method: method.rawValue, request_account_id: request_account_id, is_a_union: is_a_union), type: HelpRequestResponse.self) else { return nil }
        return response
    }

    func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}

protocol IHelpRequestViewModel {
    func getAllHelpRequests(method: RequestMethods, request_account_id: Int, is_a_union: Int) async -> HelpRequestResponse?
    func readUserCache(key: UserCacheKeys) -> Int
}
