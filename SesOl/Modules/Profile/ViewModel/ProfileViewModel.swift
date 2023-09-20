//
//  ProfileViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.05.2023.
//

import Foundation
import Alamofire
import UIKit

final class ProfileViewModel: ObservableObject {

    @Published var citizienModel: CitizienProfileResponse?
    @Published var unionModel: UnionProfileResponse?
    @Published var ibans: IbanReadResponse = IbanReadResponse()

    @Published var selectedIbanOption: IbanOptions = .create
    @Published var isUnionAccount: Int = -1
    @Published var showEdit = false
    @Published var userID: Int = -1
    @Published var quit: Bool = false
    
    @Published var ibanCreateTittle = ""
    @Published var ibanCreateNo = ""
    @Published var ibanCreated = false

    @Published var ibanUpdateId: Int = 0
    @Published var ibanUpdateTittle = ""
    @Published var ibanUpdateNo = ""
    @Published var ibanUpdated = false

    @Published var ibanDeletedId = 0
    @Published var ibanDeleted = false
    
    @Published var errorMessage: NetworkError?
    @Published var error:Bool = false
    
    private let cache = UserDefaultCache()

    func readIbans() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await NetworkManager.shared.post(url: .ibanCrud, method: .post, model: IbanReadRequest(method: RequestMethods.read_iban.rawValue, user_account_id: userId), type: IbanReadResponse.self)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    self.ibans = success
                case .failure(let failure):
                    self.errorMessage = failure
                }
            }
        }
    }

    func createIban () async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await NetworkManager.shared.post(url: .ibanCrud, method: .post, model: IbanCreateRequest(method: RequestMethods.create_iban.rawValue, user_account_id: userId, iban_title: ibanCreateTittle, iban: ibanCreateNo), type: IbanCreateResponse.self)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    if let response = success.status {
                        if response == "ok" {
                            self.ibanCreated = true
                        } else {
                            self.ibanCreated = false
                        }
                    }
                case .failure(let failure):
                    self.errorMessage = failure
                }
            }
        }

        await readIbans()
    }

    func deleteIban() async {
        let response = await NetworkManager.shared.post(url: .ibanCrud, method: .post, model: IbanDeleteRequest(method: RequestMethods.delete_iban.rawValue, iban_id: ibanDeletedId), type: IbanDeleteResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let response = success.status {
                    if response == "ok" {
                        self.ibanDeleted = true
                    } else {
                        self.ibanDeleted = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }

        await readIbans()
    }

    func updateIban() async {
        let response = await NetworkManager.shared.post(url: .ibanCrud, method: .post, model: IbanUpdateeRequest(method: RequestMethods.update_iban.rawValue, iban_id: ibanUpdateId, iban_title: ibanUpdateTittle, iban: ibanUpdateNo), type: IbanUpdateResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let response = success.status {
                    if response == "ok" {
                        self.ibanUpdated = true
                    } else {
                        self.ibanUpdated = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func readCitizien() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await NetworkManager.shared.post(url: .usersCrud, method: .post, model: CitizienProfileRequest(method: RequestMethods.read_user.rawValue, user_account_id: userId), type: CitizienProfileResponse.self)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    self.citizienModel = success
                    self.userID = success.userAccountID ?? -1
                case .failure(let failure):
                    self.userID = -1
                    self.errorMessage = failure
                }
            }
        }
    }

    func readUnion() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await NetworkManager.shared.post(url: .unionsCrud, method: .post, model: UnionProfileRequest(method: RequestMethods.read_union.rawValue, user_account_id: userId), type: UnionProfileResponse.self)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    self.unionModel = success
                    self.userID = success.userAccountID ?? -1
                case .failure(let failure):
                    self.userID = -1
                    self.errorMessage = failure
                }
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

    func quitUserAcccount() {
        cache.remove(key: .userId)
        DispatchQueue.main.async {
            self.citizienModel = nil
            self.unionModel = nil
        }
        self.quit = true
    }
}
