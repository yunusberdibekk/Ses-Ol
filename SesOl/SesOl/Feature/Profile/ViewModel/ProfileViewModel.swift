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

    @Published var selectedIbanOption: IbanOptions = .create
    @Published var isUnionAccount: Int = -1
    @Published var showEdit = false
    @Published var userID: Int = -1
    @Published var quit: Bool = false

    @Published var citizienModel: CitizienProfileResponse? = nil
    @Published var unionModel: UnionProfileResponse? = nil
    @Published var ibans: IbanReadResponse = IbanReadResponse()
    
    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()


    @Published var ibanCreateTittle = ""
    @Published var ibanCreateNo = ""
    @Published var ibanCreated = false

    @Published var ibanUpdateId: Int = 0
    @Published var ibanUpdateTittle = ""
    @Published var ibanUpdateNo = ""
    @Published var ibanUpdated = false

    @Published var ibanDeletedId = 0
    @Published var ibanDeleted = false

    func readIbans() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await readIban(method: .read_iban, user_account_id: userId)
            DispatchQueue.main.async {
                self.ibans = response
            }
        }

    }

    func createIban () async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await createIban(method: .create_iban, user_account_id: userId, iban_tittle: ibanCreateTittle, iban_no: ibanCreateNo)
            if response == "ok" {
                DispatchQueue.main.async {
                    self.ibanCreated = true
                }
                await readIbans()
            } else {
                DispatchQueue.main.async {
                    self.ibanCreated = false
                }
            }
        }
        await readIbans()
    }

    func deleteIban() async {
        let response = await deleteIban(method: .delete_iban, iban_id: ibanDeletedId)

        if response == "ok" {
            DispatchQueue.main.async {
                self.ibanDeleted = true
            }
        } else {
            DispatchQueue.main.async {
                self.ibanDeleted = false
            }
        }
        await readIbans()
    }

    func updateIban() async {
        let response = await updateIban(method: .update_iban, iban_id: ibanUpdateId, iban_tittle: ibanUpdateTittle, iban_no: ibanUpdateNo)

        if response == "ok" {
            DispatchQueue.main.async {
                self.ibanUpdated = true
            }

            await readIbans()
        } else {
            DispatchQueue.main.async {
                self.ibanUpdated = false
            }
        }

    }

    func readCitizien() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await readCitizienProfile(method: .read_user, user_account_id: userId)
            DispatchQueue.main.async {
                self.citizienModel = response
            }

            DispatchQueue.main.async {
                self.userID = response?.userAccountID ?? -1
            }
        }
    }

    func readUnion() async {
        if let userId = Int(cache.read(key: .userId)) {
            let response = await readUnionProfile(method: .read_union, user_account_id: userId)
            DispatchQueue.main.async {
                self.unionModel = response
            }

            DispatchQueue.main.async {
                self.userID = response?.userAccountID ?? -1
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

    func quitUserAcccount() {
        cache.remove(key: .userId)
        DispatchQueue.main.async {
            self.citizienModel = nil
            self.unionModel = nil
        }
        self.quit = true
    }
}

extension ProfileViewModel: IProfileViewModel {
    func deleteIban(method: RequestMethods, iban_id: Int) async -> String {
        guard let response = await networkManager.post(path: .ibanCrud, model: IbanDeleteRequest(method: method.rawValue, iban_id: iban_id), type: IbanDeleteResponse.self) else { return "burada haata" }
        return response.status ?? "error"
    }

    func updateIban(method: RequestMethods, iban_id: Int, iban_tittle: String, iban_no: String) async -> String {
        guard !iban_tittle.isEmpty else {return "error"}
        guard !iban_no.isEmpty else {return "error"}

        guard let response = await networkManager.post(path: .ibanCrud, model: IbanUpdateeRequest(method: method.rawValue, iban_id: iban_id, iban_title: iban_tittle, iban: iban_no), type: IbanUpdateResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func createIban(method: RequestMethods, user_account_id: Int, iban_tittle: String, iban_no: String) async -> String {
        guard !iban_tittle.isEmpty else {return "error"}
        guard !iban_tittle.isEmpty else {return "error"}

        guard let response = await networkManager.post(path: .ibanCrud, model: IbanCreateRequest(method: method.rawValue, user_account_id: user_account_id, iban_title: iban_tittle, iban: iban_no), type: IbanCreateResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func readIban(method: RequestMethods, user_account_id: Int) async -> IbanReadResponse {
        guard let response = await networkManager.post(path: .ibanCrud, model: IbanReadRequest(method: method.rawValue, user_account_id: user_account_id), type: IbanReadResponse.self) else { return IbanReadResponse() }
        return response
    }
    func readCitizienProfile(method: RequestMethods, user_account_id: Int) async -> CitizienProfileResponse? {
        guard let response = await networkManager.post(path: .usersCrud, model: CitizienProfileRequest(method: method.rawValue, user_account_id: user_account_id), type: CitizienProfileResponse.self) else { return nil }
        return response
    }

    func readUnionProfile(method: RequestMethods, user_account_id: Int) async -> UnionProfileResponse? {
        guard let response = await networkManager.post(path: .unionsCrud, model: UnionProfileRequest(method: method.rawValue, user_account_id: user_account_id), type: UnionProfileResponse.self) else { return nil }
        return response
    }

    func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }

}

protocol IProfileViewModel {
    func readCitizienProfile(method: RequestMethods, user_account_id: Int) async -> CitizienProfileResponse?
    func readUnionProfile(method: RequestMethods, user_account_id: Int) async -> UnionProfileResponse?
    func readIban(method: RequestMethods, user_account_id: Int) async -> IbanReadResponse
    func createIban(method: RequestMethods, user_account_id: Int, iban_tittle: String, iban_no: String) async -> String
    func updateIban(method: RequestMethods, iban_id: Int, iban_tittle: String, iban_no: String) async -> String
    func deleteIban(method: RequestMethods, iban_id: Int) async -> String
    func readUserCache(key: UserCacheKeys) -> Int
}
