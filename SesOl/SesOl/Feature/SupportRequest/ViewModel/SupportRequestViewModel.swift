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

    @Published var waitingSupportRequests: ProvidingAssistanceResponse? = nil
    @Published var rejectedSupportRequests: ProvidingAssistanceResponse? = nil
    @Published var approvedSupportRequests: ProvidingAssistanceResponse? = nil

    @Published var waitingVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse? = nil
    @Published var rejectedVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse? = nil
    @Published var approvedVoluntarilyPitchTentRequests: VoluntarilyPitchTentResponse? = nil

    @Published var waitingVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse? = nil
    @Published var rejectedVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse? = nil
    @Published var approvedVoluntarilyPsychologistRequests: VoluntarilyPsychologistResponse? = nil

    @Published var waitingVoluntarilyTransporterRequests: VoluntarilyTransporterResponse? = nil
    @Published var rejectedVoluntarilyTransporterRequests: VoluntarilyTransporterResponse? = nil
    @Published var approvedVoluntarilyTransporterRequests: VoluntarilyTransporterResponse? = nil

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func getApprovedSupportRequests() async {
        let approvedRequests = await getProvidingAssistanceRequests(method: .read_approved_providing, user_assistance_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.approvedSupportRequests = approvedRequests
        }
    }

    func getWaitingSupportRequests() async {
        let waitingRequests = await getProvidingAssistanceRequests(method: .read_waiting_providing, user_assistance_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.waitingSupportRequests = waitingRequests
        }
    }

    func getRejectedSupportRequests() async {
        let rejectedRequests = await getProvidingAssistanceRequests(method: .read_rejected_providing, user_assistance_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.rejectedSupportRequests = rejectedRequests
        }
    }

    func getWaitingVoluntarilyPitchTent() async {
        let response = await getVoluntarilyPitchTent(method: .read_waiting_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.waitingVoluntarilyPitchTentRequests = response
        }
    }

    func getRejectedVoluntarilyPitchTent() async {
        let response = await getVoluntarilyPitchTent(method: .read_rejected_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.rejectedVoluntarilyPitchTentRequests = response
        }
    }

    func getApprovedVoluntarilyPitchTent() async {
        let response = await getVoluntarilyPitchTent(method: .read_approved_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.approvedVoluntarilyPitchTentRequests = response
        }
    }

    func getWaitingVoluntarilyPsychologist() async {
        let response = await getVoluntarilyPsychologist(method: .read_waiting_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.waitingVoluntarilyPsychologistRequests = response
        }
    }

    func getRejectedVoluntarilyPsychologist() async {
        let response = await getVoluntarilyPsychologist(method: .read_rejected_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.rejectedVoluntarilyPsychologistRequests = response
        }
    }

    func getApprovedVoluntarilyPsychologist() async {
        let response = await getVoluntarilyPsychologist(method: .read_approved_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.approvedVoluntarilyPsychologistRequests = response
        }
    }

    func getWaitingVoluntarilyTransporter() async {
        let response = await getVoluntarilyTransporter(method: .read_waiting_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.waitingVoluntarilyTransporterRequests = response
        }
    }

    func getRejectedVoluntarilyTransporter() async {
        let response = await getVoluntarilyTransporter(method: .read_rejected_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.rejectedVoluntarilyTransporterRequests = response
        }
    }

    func getApprovedVoluntarilyTransporter() async {
        let response = await getVoluntarilyTransporter(method: .read_approved_providing, user_account_id: userID, is_a_union: isUnionAccount)
        DispatchQueue.main.async {
            self.approvedVoluntarilyTransporterRequests = response
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
}

extension SupportRequestViewModel: ISupportRequestViewModel {
    func getVoluntarilyPitchTent(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyPitchTentResponse? {
        guard let response = await networkManager.post(path: .voluntarilyPitchTent, model: VoluntarilyPitchTentRequest(method: method.rawValue, user_account_id: user_account_id, is_a_union: is_a_union), type: VoluntarilyPitchTentResponse.self) else { return nil }
        return response
    }

    func getVoluntarilyPsychologist(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyPsychologistResponse? {
        guard let response = await networkManager.post(path: .voluntarilyPsychologist, model: VoluntarilyPsychologistRequest(method: method.rawValue, user_account_id: user_account_id, is_a_union: is_a_union), type: VoluntarilyPsychologistResponse.self) else { return nil }
        return response
    }

    func getVoluntarilyTransporter(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyTransporterResponse? {
        guard let response = await networkManager.post(path: .voluntarilyTransporter, model: VoluntarilyTransporterRequest(method: method.rawValue, user_account_id: user_account_id, is_a_union: is_a_union), type: VoluntarilyTransporterResponse.self) else { return nil }
        return response
    }

    func getProvidingAssistanceRequests(method: RequestMethods, user_assistance_account_id: Int, is_a_union: Int) async -> ProvidingAssistanceResponse? {
        guard let response = await networkManager.post(path: .providingAssistanceCrud, model: ProvidingAssistanceRequest(method: method.rawValue, user_assistance_account_id: user_assistance_account_id, is_a_union: is_a_union), type: ProvidingAssistanceResponse.self) else { return nil }
        return response
    }

    func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}

protocol ISupportRequestViewModel {
    func getVoluntarilyPitchTent(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyPitchTentResponse?
    func getVoluntarilyPsychologist(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyPsychologistResponse?
    func getVoluntarilyTransporter(method: RequestMethods, user_account_id: Int, is_a_union: Int) async -> VoluntarilyTransporterResponse?
    func getProvidingAssistanceRequests(method: RequestMethods, user_assistance_account_id: Int, is_a_union: Int) async -> ProvidingAssistanceResponse?
    func readUserCache(key: UserCacheKeys) -> Int
}
