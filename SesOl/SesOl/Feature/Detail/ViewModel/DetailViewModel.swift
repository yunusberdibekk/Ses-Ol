//
//  DetailViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import Foundation

class DetailViewModel: ObservableObject {

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    /// Readed userID value in UserDefaults
    @Published var userID = -1
    /// Readed isUnionAccount value in UserDefaults
    @Published var isUnionAccount = -1
    @Published var requestId = -1
    @Published var post_id = -1 //default -1
    @Published var assistance_id = -1
    @Published var request_id = -1
    @Published var voluntarily_account_id = -1

    @Published var status = ""
    @Published var deletePostStatus = ""
    @Published var deleteSupportRequestStatus = ""

    @Published var isDeletedVoluntarily = false
    @Published var isDeletedProvidingAssistance = false
    @Published var isDeletedHelpRequest = false
    @Published var isDeletedPost = false

    func rejectVoluntarilyPitchTent() async {
        let response = await updateVoluntarilyPitchTent(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 0)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func approveVoluntarilyPitchTent() async {
        let response = await updateVoluntarilyPitchTent(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 1)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func rejectVoluntarilyPsychologist() async {
        print(userID)
        let response = await updateVoluntarilyPsychologist(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 0)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func approveVoluntarilyPsychologist() async {
        let response = await updateVoluntarilyPsychologist(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 1)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func rejectVoluntarilyTransporter() async {
        let response = await updateVoluntarilyTransporter(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 0)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func approveVoluntarilyTransporter() async {
        let response = await updateVoluntarilyTransporter(method: "update_voluntarily", user_account_id: voluntarily_account_id, voluntarily_approve_status: 1)
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func deleteVoluntarilyPitchTent() async {
        let response = await deleteVoluntarilyPitchTent(method: "delete_voluntarily", user_account_id: userID)
        changeVoluntarilyStatus(response: response)
    }

    func deleteVoluntarilyPsychologist() async {
        let response = await deleteVoluntarilyPsychologist(method: "delete_voluntarily", user_account_id: userID)
        changeVoluntarilyStatus(response: response)

    }

    func deleteVoluntarilyTransporter() async {
        let response = await deleteVoluntarilyTransporter(method: "delete_voluntarily", user_account_id: userID)
        print(response)
        changeVoluntarilyStatus(response: response)
    }

    func deletePost() async {
        let response = await deletePost(method: "delete_post", post_id: post_id)

        DispatchQueue.main.async {
            self.deletePostStatus = response
        }

        print(response)
    }

    func deleteSupportRequest() async {
        let response = await deleteSupportRequest(method: "delete_my_assistance", assistance_id: assistance_id)

        DispatchQueue.main.async {
            self.deleteSupportRequestStatus = response
        }

        print(response)
    }

    func deleteHelpRequest(request_id_value: Int) async {
        let response = await deleteHelpRequest(method: "delete_request", request_id: request_id_value)

        DispatchQueue.main.async {
            self.deleteSupportRequestStatus = response
        }

        print(response)
    }

    func rejectRequest() async {
        let response = await updateRequestStatus(method: "update_request_status", request_id: requestId, request_status: 0, is_a_union: 1)
        //
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func approveRequest() async {
        let response = await updateRequestStatus(method: "update_request_status", request_id: requestId, request_status: 1, is_a_union: 1)

        DispatchQueue.main.async {
            self.status = response
        }
    }

    func rejectSupportRequest() async {
        let response = await updateSupportRequestStatus(method: "update_my_assistance", assistance_id: assistance_id, assistance_status: 0)
        //
        DispatchQueue.main.async {
            self.status = response
        }
        print(response)
    }

    func approveSupportRequest() async {
        let response = await updateSupportRequestStatus(method: "update_my_assistance", assistance_id: assistance_id, assistance_status: 1)
        DispatchQueue.main.async {
            self.status = response
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

    func changeVoluntarilyStatus(response: String) {
        if response == "ok" {
            self.isDeletedVoluntarily = true
        } else {
            self.isDeletedVoluntarily = false
        }
    }

}

extension DetailViewModel: IDetailViewModel {
    func updateVoluntarilyPitchTent(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyPitchTent, model: UpdateVoluntarilyPitchTentRequest(method: method, user_account_id: user_account_id, voluntarily_approve_status: voluntarily_approve_status), type: UpdateVoluntarilyPitchTentResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func updateVoluntarilyTransporter(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyTransporter, model: UpdateVoluntarilyTransporterRequest(method: method, user_account_id: user_account_id, voluntarily_approve_status: voluntarily_approve_status), type: UpdateVoluntarilyTransporterResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func updateVoluntarilyPsychologist(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyPsychologist, model: UpdateVoluntarilyPsychologistRequest(method: method, user_account_id: user_account_id, voluntarily_approve_status: voluntarily_approve_status), type: UpdateVoluntarilyPsychologistResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func deleteVoluntarilyPitchTent(method: String, user_account_id: Int) async -> String {
        guard !(user_account_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .voluntarilyPitchTent, model: DeleteVoluntarilyRequest(method: method, user_account_id: user_account_id), type: DeleteVoluntarilyResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func deleteVoluntarilyTransporter(method: String, user_account_id: Int) async -> String {
        guard !(user_account_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .voluntarilyTransporter, model: DeleteVoluntarilyRequest(method: method, user_account_id: user_account_id), type: DeleteVoluntarilyResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func deleteVoluntarilyPsychologist(method: String, user_account_id: Int) async -> String {
        guard !(user_account_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .voluntarilyPsychologist, model: DeleteVoluntarilyRequest(method: method, user_account_id: user_account_id), type: DeleteVoluntarilyResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func deleteSupportRequest(method: String, assistance_id: Int) async -> String {
        guard !(assistance_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .providingAssistanceCrud, model: DeleteSupportRequest(method: method, assistance_id: assistance_id), type: DeleteSupportRequestResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func deleteHelpRequest(method: String, request_id: Int) async -> String {
        guard !(request_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .requestCrud, model: DeleteHelpRequest(method: method, request_id: request_id), type: DeleteHelpRequestResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func deletePost(method: String, post_id: Int) async -> String {
        guard !(post_id == -1) else { return "error" }
        guard let response = await networkManager.post(path: .unionPostCrud, model: DeletePostRequest(method: method, post_id: post_id), type: DeletePostResponse.self) else { return "error" }

        return response.status ?? "error"
    }

    func updateRequestStatus(method: String, request_id: Int, request_status: Int, is_a_union: Int) async -> String {
        guard let response = await networkManager.post(path: .requestCrud, model: UpdateRequest(method: method, request_id: request_id, request_status: request_status, is_a_union: is_a_union), type: UpdateRequestReponse.self) else { return "error" } //{"status":"ok","msg":"success"} if request's accepted.
        return response.status!
    }

    func updateSupportRequestStatus(method: String, assistance_id: Int, assistance_status: Int) async -> String {
        guard let response = await networkManager.post(path: .providingAssistanceCrud, model: UpdateSupportRequest(method: method, assistance_id: assistance_id, assistance_status: assistance_status), type: UpdateSupportRequestReponse.self) else { return "error" } //{"status":"ok","msg":"success"} if request's accepted.
        return response.status!
    }


    func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}

protocol IDetailViewModel {
    func updateRequestStatus(method: String, request_id: Int, request_status: Int, is_a_union: Int) async -> String
    func readUserCache(key: UserCacheKeys) -> Int
    func updateSupportRequestStatus(method: String, assistance_id: Int, assistance_status: Int) async -> String
    func deleteSupportRequest(method: String, assistance_id: Int) async -> String
    func deleteHelpRequest(method: String, request_id: Int) async -> String
    func deletePost(method: String, post_id: Int) async -> String
    func deleteVoluntarilyPitchTent(method: String, user_account_id: Int) async -> String
    func deleteVoluntarilyTransporter(method: String, user_account_id: Int) async -> String
    func deleteVoluntarilyPsychologist(method: String, user_account_id: Int) async -> String

    func updateVoluntarilyPitchTent(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String
    func updateVoluntarilyTransporter(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String
    func updateVoluntarilyPsychologist(method: String, user_account_id: Int, voluntarily_approve_status: Int) async -> String
}

