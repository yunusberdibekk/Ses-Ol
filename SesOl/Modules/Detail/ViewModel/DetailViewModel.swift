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

    @Published var errorMessage: NetworkError?

    @Published var isDeletedVoluntarily = false
    @Published var isDeletedSupportRequest = false
    @Published var isDeletedHelpRequest = false
    @Published var isDeletedPost = false

    @Published var isUpdatedVoluntarily = false
    @Published var isUpdatedSupportRequest = false
    @Published var isUpdatedHelpRequest = false
    @Published var isUpdatedPost = false

    func rejectVoluntarilyPitchTent() async {
        await updateVoluntarilyPitchTent(approveStatus: 0)
    }

    func approveVoluntarilyPitchTent() async {
        await updateVoluntarilyPitchTent(approveStatus: 1)
    }

    func rejectVoluntarilyPsychologist() async {
        await updateVoluntarilyPsychologist(approveStatus: 0)
    }

    func approveVoluntarilyPsychologist() async {
        await updateVoluntarilyPsychologist(approveStatus: 1)
    }

    func rejectVoluntarilyTransporter() async {
        await updateVoluntarilyTransporter(approveStatus: 0)
    }

    func approveVoluntarilyTransporter() async {
        await updateVoluntarilyTransporter(approveStatus: 1)
    }

    func rejectSupportRequest() async {
        await updateSupportRequest(approveStatus: 0)
    }

    func approveSupportRequest() async {
        await updateSupportRequest(approveStatus: 1)
    }

    func rejectRequest() async {
        await updateHelpRequest(approveStatus: 0)
    }

    func approveRequest() async {
        await updateHelpRequest(approveStatus: 1)
    }

    func deleteVoluntarilyPitchTent() async {
        await deleteVoluntarily(path: .voluntarilyPitchTent)
    }

    func deleteVoluntarilyPsychologist() async {
        await deleteVoluntarily(path: .voluntarilyPsychologist)
    }

    func deleteVoluntarilyTransporter() async {
        await deleteVoluntarily(path: .voluntarilyTransporter)
    }

    /// Delete support request
    func deleteSupportRequest() async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: DeleteSupportRequest(method: RequestMethods.delete_my_assistance.rawValue, assistance_id: assistance_id), type: DeleteSupportRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //    self.deleteSupportRequestStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    /// Delete voluntarily request.
    /// - Parameter path: NetworkPath
    private func deleteVoluntarily(path: NetworkPath) async {
        let response = await NetworkManager.shared.post(url: path, method: .post, model: DeleteVoluntarilyRequest(method: RequestMethods.delete_volantarily.rawValue, user_account_id: userID), type: DeleteVoluntarilyResponse.self)
        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    self.changeVoluntarilyStatus(response: status)
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    /// Delete user help request.
    /// - Parameter request_id_value: request_id_value
    func deleteHelpRequest(request_id_value: Int) async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: DeleteHelpRequest(method: RequestMethods.delete_request.rawValue, request_id: request_id), type: DeleteHelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //          self.deleteHelpRequestStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    /// Delete union posts.
    func deletePost() async {
        let response = await NetworkManager.shared.post(url: .unionPostCrud, method: .post, model: DeletePostRequest(method: RequestMethods.delete_post.rawValue, post_id: post_id), type: DeletePostResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //        self.deletePostStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    private func updateSupportRequest(approveStatus: Int) async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: UpdateSupportRequest(method: RequestMethods.update_my_assistance.rawValue, assistance_id: assistance_id, assistance_status: approveStatus), type: UpdateSupportRequestReponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //    self.updateSupportRequestStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    private func updateHelpRequest(approveStatus: Int) async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: UpdateRequest(method: RequestMethods.update_request_status.rawValue, request_id: requestId, request_status: approveStatus, is_a_union: 1), type: UpdateRequestReponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //        self.updateHelpRequestStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }


    private func updateVoluntarilyPitchTent(approveStatus: Int) async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPitchTent, method: .post, model: UpdateVoluntarilyPitchTentRequest(method: RequestMethods.update_voluntarily.rawValue, user_account_id: voluntarily_account_id, voluntarily_approve_status: approveStatus), type: UpdateVoluntarilyPitchTentResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //       self.updateVoluntarilyStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    private func updateVoluntarilyPsychologist(approveStatus: Int) async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: UpdateVoluntarilyPsychologistRequest(method: RequestMethods.update_voluntarily.rawValue, user_account_id: voluntarily_account_id, voluntarily_approve_status: approveStatus), type: UpdateVoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //       self.updateVoluntarilyStatus = status
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    private func updateVoluntarilyTransporter(approveStatus: Int) async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: UpdateVoluntarilyTransporterRequest(method: RequestMethods.update_voluntarily.rawValue, user_account_id: voluntarily_account_id, voluntarily_approve_status: approveStatus), type: UpdateVoluntarilyTransporterResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    //       self.updateVoluntarilyStatus = status
                }
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

    func changeVoluntarilyStatus(response: String) {
        if response == "ok" {
            self.isDeletedVoluntarily = true
        } else {
            self.isDeletedVoluntarily = false
        }
    }

    func changeHelpRequestStatus(response: String) {
        if response == "ok" {
            self.isDeletedHelpRequest = true
        } else {
            self.isDeletedHelpRequest = false
        }
    }

    func changePostRequestStatus(response: String) {
        if response == "ok" {
            self.isDeletedPost = true
        } else {
            self.isDeletedPost = false
        }
    }

    @MainActor
    private func changeSupportRequestStatus(status: String?) {
        if let status = status {
            if status == "ok" {
                self.isDeletedSupportRequest = true
            } else {
                self.isDeletedSupportRequest = false
            }
        } else {
            self.isDeletedSupportRequest = false
        }
    }
    
    @MainActor
    private func changeHelpRequestStatus(status: String?) {
        if let status = status {
            if status == "ok" {
                self.isDeletedHelpRequest = true
            } else {
                self.isDeletedHelpRequest = false
            }
        } else {
            self.isDeletedHelpRequest = false
        }
    }
    
    @MainActor
    private func changePostStatus(status: String?) {
        if let status = status {
            if status == "ok" {
                self.isDeletedPost = true
            } else {
                self.isDeletedPost = false
            }
        } else {
            self.isDeletedPost = false
        }
    }

    private func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}
