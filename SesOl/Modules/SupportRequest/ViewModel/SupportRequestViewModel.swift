//
//  SupportRequestViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import Foundation

class SupportRequestViewModel: ObservableObject {

    // -1 bekleyen, 0 reddedilen, 1 onaylanan
    @Published var selectedOption: RequestOptions = .waiting
    //0 diğer, 1 psikolog, 1 çadır kurma, 2 taşıma
    @Published var selectedSupportType: SupportType = .providingAssistance

    /// Readed userID value in UserDefaults
    @Published var userID = -1
    /// Readed isUnionAccount value in UserDefaults
    @Published var isUnionAccount = 0

    @Published var waitingSupportRequests: ProvidingAssistanceResponse?
    @Published var rejectedSupportRequests: ProvidingAssistanceResponse?
    @Published var approvedSupportRequests: ProvidingAssistanceResponse?

    @Published var waitingVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse?
    @Published var rejectedVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse?
    @Published var approvedVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse?

    @Published var waitingVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse?
    @Published var rejectedVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse?
    @Published var approvedVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse?

    @Published var waitingVoluntarilyTransporterRequests: VoluntarilyTransporterResponse?
    @Published var rejectedVoluntarilyTransporterRequests: VoluntarilyTransporterResponse?
    @Published var approvedVoluntarilyTransporterRequests: VoluntarilyTransporterResponse?

    @Published var error = false
    @Published var errorMessage: NetworkError?

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func getApprovedSupportRequests() async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: ProvidingAssistanceRequest(method: RequestMethods.read_approved_providing.rawValue, user_assistance_account_id: userID, is_a_union: isUnionAccount), type: ProvidingAssistanceResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.approvedSupportRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getWaitingSupportRequests() async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: ProvidingAssistanceRequest(method: RequestMethods.read_waiting_providing.rawValue, user_assistance_account_id: userID, is_a_union: isUnionAccount), type: ProvidingAssistanceResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.waitingSupportRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getRejectedSupportRequests() async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: ProvidingAssistanceRequest(method: RequestMethods.read_rejected_providing.rawValue, user_assistance_account_id: userID, is_a_union: isUnionAccount), type: ProvidingAssistanceResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.rejectedSupportRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getWaitingVoluntarilyPitchTent() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPitchTent, method: .post, model: VoluntarilyPitchTentRequest(method: RequestMethods.read_waiting_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPitchTentResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.waitingVoluntarilyPitchTentRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getRejectedVoluntarilyPitchTent() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPitchTent, method: .post, model: VoluntarilyPitchTentRequest(method: RequestMethods.read_rejected_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPitchTentResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.rejectedVoluntarilyPitchTentRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getApprovedVoluntarilyPitchTent() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPitchTent, method: .post, model: VoluntarilyPitchTentRequest(method: RequestMethods.read_approved_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPitchTentResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.approvedVoluntarilyPitchTentRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getWaitingVoluntarilyPsychologist() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: VoluntarilyPsychologistRequest(method: RequestMethods.read_waiting_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.waitingVoluntarilyPsychologistRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getRejectedVoluntarilyPsychologist() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: VoluntarilyPsychologistRequest(method: RequestMethods.read_rejected_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.rejectedVoluntarilyPsychologistRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getApprovedVoluntarilyPsychologist() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: VoluntarilyPsychologistRequest(method: RequestMethods.read_approved_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.approvedVoluntarilyPsychologistRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getWaitingVoluntarilyTransporter() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyTransporter, method: .post, model: VoluntarilyTransporterRequest(method: RequestMethods.read_waiting_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyTransporterResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.waitingVoluntarilyTransporterRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getRejectedVoluntarilyTransporter() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyTransporter, method: .post, model: VoluntarilyTransporterRequest(method: RequestMethods.read_rejected_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyTransporterResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.rejectedVoluntarilyTransporterRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getApprovedVoluntarilyTransporter() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyTransporter, method: .post, model: VoluntarilyTransporterRequest(method: RequestMethods.read_approved_providing.rawValue, user_account_id: userID, is_a_union: isUnionAccount), type: VoluntarilyTransporterResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.approvedVoluntarilyTransporterRequests = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func refreshSupportRequests(newValue: SupportType) async {
        switch newValue {
        case .providingAssistance:
            await getWaitingSupportRequests()
            await getRejectedSupportRequests()
            await getApprovedSupportRequests()
        case .psychologist:
            await getWaitingVoluntarilyPsychologist()
            await getRejectedVoluntarilyPsychologist()
            await getApprovedVoluntarilyPsychologist()
        case .pitchTent:
            await getWaitingVoluntarilyPitchTent()
            await getRejectedVoluntarilyPitchTent()
            await getApprovedVoluntarilyPitchTent()
        case .transporter:
            await getWaitingVoluntarilyTransporter()
            await getRejectedVoluntarilyTransporter()
            await getApprovedVoluntarilyTransporter()
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
