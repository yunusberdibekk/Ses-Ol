//
//  SOSupportRequestListViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

final class SOSupportRequestListViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID: Int = 0

    @Published var logStatus: Bool = false
    @Published var logMessage: String = ""

    @Published var selectedRequestStatus: RequestStatus = .waiting
    @Published var selectedSupportRequestType: SupportRequestTypes = .standart

    @Published var waitingStandartSupportRequests: ProvidingAssistanceResponse = []
    @Published var rejectedStandartSupportRequests: ProvidingAssistanceResponse = []
    @Published var approvedStandartSupportRequests: ProvidingAssistanceResponse = []

    @Published var waitingPsyhlogistSupportRequests: VoluntarilyPsychologistResponse = []
    @Published var rejectedPsyhlogistSupportRequests: VoluntarilyPsychologistResponse = []
    @Published var approvedPsyhlogistSupportRequests: VoluntarilyPsychologistResponse = []

    @Published var waitingPitchTentSupportRequests: VoluntarilyPitchTentResponse = []
    @Published var rejectedPitchTentSupportRequests: VoluntarilyPitchTentResponse = []
    @Published var approvedPitchTentSupportRequests: VoluntarilyPitchTentResponse = []

    @Published var waitingTransporterSupportRequests: VoluntarilyTransporterResponse = []
    @Published var rejectedTransporterSupportRequests: VoluntarilyTransporterResponse = []
    @Published var approvedTransporterSupportRequests: VoluntarilyTransporterResponse = []

    func resetProperties() {}

    @MainActor
    private func showMessage(message: String) {
        logMessage = message
        logStatus.toggle()
    }

    // MARK: - Fetch

    func fetchAdditionalSupportRequests(status: RequestStatus) async {
        Task {
            switch status {
            case .waiting:
                print("fetching waiting")
                await getWaitingStandartSupportRequests()
                await getWaitingPsychologistSupportRequests()
                await getWaitingPitchTentSupportRequests()
                await getWaitingTransporterSupportRequests()
            case .rejected:
                print("fetching rejected")
                await getRejectedStandartSupportRequests()
                await getRejectedPsychologistSupportRequests()
                await getRejectedPitchTentSupportRequests()
                await getRejectedTransporterSupportRequests()
            case .approved:
                print("fetching approved")
                await getApprovedStandartSupportRequests()
                await getApprovedPsychologistSupportRequests()
                await getApprovedPitchTentSupportRequests()
                await getApprovedTransporterSupportRequests()
            }
        }
    }

    func getApprovedStandartSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: ProvidingAssistanceRequest(
                method: RequestMethods.read_approved_providing.rawValue,
                user_assistance_account_id: userID,
                is_a_union: userType.rawValue),
            type: ProvidingAssistanceResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.approvedStandartSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getWaitingStandartSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: ProvidingAssistanceRequest(
                method: RequestMethods.read_waiting_providing.rawValue,
                user_assistance_account_id: userID,
                is_a_union: userType.rawValue),
            type: ProvidingAssistanceResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.waitingStandartSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getRejectedStandartSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: ProvidingAssistanceRequest(
                method: RequestMethods.read_rejected_providing.rawValue,
                user_assistance_account_id: userID,
                is_a_union: userType.rawValue),
            type: ProvidingAssistanceResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.rejectedStandartSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getWaitingPitchTentSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPitchTent,
            method: .post,
            model: VoluntarilyPitchTentRequest(
                method: RequestMethods.read_waiting_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPitchTentResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.waitingPitchTentSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getRejectedPitchTentSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPitchTent,
            method: .post,
            model: VoluntarilyPitchTentRequest(
                method: RequestMethods.read_rejected_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPitchTentResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.rejectedPitchTentSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getApprovedPitchTentSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPitchTent,
            method: .post,
            model: VoluntarilyPitchTentRequest(
                method: RequestMethods.read_approved_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPitchTentResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.approvedPitchTentSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getWaitingPsychologistSupportRequests() async {
        let response = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: VoluntarilyPsychologistRequest(
                method: RequestMethods.read_waiting_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPsychologistResponse.self)
        switch response {
        case .success(let models):
            DispatchQueue.main.async {
                self.waitingPsyhlogistSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getRejectedPsychologistSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: VoluntarilyPsychologistRequest(
                method: RequestMethods.read_rejected_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPsychologistResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.rejectedPsyhlogistSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getApprovedPsychologistSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: VoluntarilyPsychologistRequest(
                method: RequestMethods.read_approved_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyPsychologistResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.approvedPsyhlogistSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getWaitingTransporterSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyTransporter,
            method: .post,
            model: VoluntarilyTransporterRequest(
                method: RequestMethods.read_waiting_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyTransporterResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.waitingTransporterSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getRejectedTransporterSupportRequests() async {
        let response = await NetworkManager.shared.post(
            url: .voluntarilyTransporter,
            method: .post,
            model: VoluntarilyTransporterRequest(
                method: RequestMethods.read_rejected_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyTransporterResponse.self)
        switch response {
        case .success(let models):
            DispatchQueue.main.async {
                self.rejectedTransporterSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func getApprovedTransporterSupportRequests() async {
        let result = await NetworkManager.shared.post(
            url: .voluntarilyTransporter,
            method: .post,
            model: VoluntarilyTransporterRequest(
                method: RequestMethods.read_approved_providing.rawValue,
                user_account_id: userID,
                is_a_union: userType.rawValue),
            type: VoluntarilyTransporterResponse.self)
        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.approvedTransporterSupportRequests = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    // MARK: - Update

    /// Update  support request  status. For union.
    func updateStandartSupportRequest(
        status: UpdateRequestStatus,
        request: ProvidingAssistanceResponseElement,
        index: Int) async
    {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: UpdateSupportRequest(
                method: RequestMethods.update_my_assistance.rawValue,
                assistance_id: request.assistanceID,
                assistance_status: status.rawValue),
            type: UpdateSupportRequestReponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await updateStandartSupportRequestList(status, at: index, with: request)
                await showMessage(message: "Güncelleme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    /// Update  support  request  status. For union.
    func updatePitchTentSupportRequest(
        status: UpdateRequestStatus,
        request: VoluntarilyPitchTentResponseElement,
        index: Int) async
    {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPitchTent,
            method: .post,
            model: UpdateVoluntarilyPitchTentRequest(
                method: RequestMethods.update_voluntarily.rawValue,
                user_account_id: request.voluntarilyAccountID,
                voluntarily_approve_status: status.rawValue),
            type: UpdateVoluntarilyPitchTentResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await updatePitchTentSupportRequestList(status, at: index, with: request)
                await showMessage(message: "Güncelleme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    /// Update  support  request  status. For union.
    func updatePsychologistSupportRequest(
        status: UpdateRequestStatus,
        request: VoluntarilyPsychologistResponseElement,
        index: Int) async
    {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: UpdateVoluntarilyPsychologistRequest(
                method: RequestMethods.update_voluntarily.rawValue,
                user_account_id: request.voluntarilyAccountID,
                voluntarily_approve_status: status.rawValue),
            type: UpdateVoluntarilyPsychologistResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await updatePsyhologistSupportRequestList(status, at: index, with: request)
                await showMessage(message: "Güncelleme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    /// Update  support  request  status. For union.
    func updateTransporterSupportRequest(
        status: UpdateRequestStatus,
        request: VoluntarilyTransporterResponseElement,
        index: Int) async
    {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: UpdateVoluntarilyTransporterRequest(
                method: RequestMethods.update_voluntarily.rawValue,
                user_account_id: request.voluntarilyAccountID,
                voluntarily_approve_status: status.rawValue),
            type: UpdateVoluntarilyTransporterResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await updateTransporterSupportRequestList(status, at: index, with: request)
                await showMessage(message: "Güncelleme işlemi başarıyla gerçekleşti.")
            } else {
                await showMessage(message: model.msg)
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    // MARK: - Delete

    func deleteStandartSupportRequest(requestID: Int, index: Int) async {
        guard userType == .citizien else { return }
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: DeleteSupportRequest(
                method: RequestMethods.delete_my_assistance.rawValue,
                assistance_id: requestID),
            type: DeleteSupportRequestResponse.self)

        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Silme işlemi başarıyla gerçekleşti.")
                await deleteRequest(at: index)
            } else {
                await showMessage(message: "Talep silinirken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func deleteSupportRequest(path: NetworkPath, index: Int) async {
        guard userType == .citizien else { return }
        let result = await NetworkManager.shared.post(
            url: path, method: .post,
            model: DeleteVoluntarilyRequest(
                method: RequestMethods.delete_voluntarily.rawValue,
                user_account_id: userID),
            type: DeleteVoluntarilyResponse.self)

        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Silme işlemi başarıyla gerçekleşti.")
                await deleteRequest(at: index)
            } else {
                await showMessage(message: "Talep silinirken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    @MainActor
    private func deleteRequest(at index: Int) {
        switch selectedSupportRequestType {
        case .standart:
            switch selectedRequestStatus {
            case .waiting:
                waitingStandartSupportRequests.remove(at: index)
            case .rejected:
                rejectedStandartSupportRequests.remove(at: index)
            case .approved:
                approvedStandartSupportRequests.remove(at: index)
            }
        case .psyhlogist:
            switch selectedRequestStatus {
            case .waiting:
                waitingPsyhlogistSupportRequests.remove(at: index)
            case .rejected:
                rejectedStandartSupportRequests.remove(at: index)
            case .approved:
                approvedStandartSupportRequests.remove(at: index)
            }
        case .pitchtent:
            switch selectedRequestStatus {
            case .waiting:
                waitingPitchTentSupportRequests.remove(at: index)
            case .rejected:
                rejectedPitchTentSupportRequests.remove(at: index)
            case .approved:
                approvedPitchTentSupportRequests.remove(at: index)
            }
        case .transporter:
            switch selectedRequestStatus {
            case .waiting:
                waitingTransporterSupportRequests.remove(at: index)
            case .rejected:
                waitingTransporterSupportRequests.remove(at: index)
            case .approved:
                approvedTransporterSupportRequests.remove(at: index)
            }
        }
    }

    @MainActor
    private func updateStandartSupportRequestList(
        _ status: UpdateRequestStatus, at index: Int, with request: ProvidingAssistanceResponseElement)
    {
        switch selectedRequestStatus {
        case .waiting:
            if status == .reject {
                waitingStandartSupportRequests.remove(at: index)
                rejectedStandartSupportRequests.append(request)
            } else {
                waitingStandartSupportRequests.remove(at: index)
                approvedStandartSupportRequests.append(request)
            }
        case .rejected:
            if status == .approve {
                rejectedStandartSupportRequests.remove(at: index)
                approvedStandartSupportRequests.append(request)
            }
        case .approved:
            if status == .reject {
                approvedStandartSupportRequests.remove(at: index)
                rejectedStandartSupportRequests.append(request)
            }
        }
    }

    @MainActor
    private func updatePsyhologistSupportRequestList(
        _ status: UpdateRequestStatus, at index: Int, with request: VoluntarilyPsychologistResponseElement)
    {
        switch selectedRequestStatus {
        case .waiting:
            if status == .reject {
                waitingPsyhlogistSupportRequests.remove(at: index)
                rejectedPsyhlogistSupportRequests.append(request)
            } else {
                waitingPsyhlogistSupportRequests.remove(at: index)
                approvedPsyhlogistSupportRequests.append(request)
            }
        case .rejected:
            if status == .approve {
                rejectedPsyhlogistSupportRequests.remove(at: index)
                approvedPsyhlogistSupportRequests.append(request)
            }
        case .approved:
            if status == .reject {
                approvedPsyhlogistSupportRequests.remove(at: index)
                rejectedPsyhlogistSupportRequests.append(request)
            }
        }
    }

    @MainActor
    private func updatePitchTentSupportRequestList(
        _ status: UpdateRequestStatus, at index: Int, with request: VoluntarilyPitchTentResponseElement)
    {
        switch selectedRequestStatus {
        case .waiting:
            if status == .reject {
                waitingPitchTentSupportRequests.remove(at: index)
                rejectedPitchTentSupportRequests.append(request)
            } else {
                waitingPitchTentSupportRequests.remove(at: index)
                approvedPitchTentSupportRequests.append(request)
            }
        case .rejected:
            if status == .approve {
                rejectedPitchTentSupportRequests.remove(at: index)
                approvedPitchTentSupportRequests.append(request)
            }
        case .approved:
            if status == .reject {
                approvedPitchTentSupportRequests.remove(at: index)
                rejectedPitchTentSupportRequests.append(request)
            }
        }
    }

    @MainActor
    private func updateTransporterSupportRequestList(
        _ status: UpdateRequestStatus, at index: Int, with request: VoluntarilyTransporterResponseElement)
    {
        switch selectedRequestStatus {
        case .waiting:
            if status == .reject {
                waitingTransporterSupportRequests.remove(at: index)
                rejectedTransporterSupportRequests.append(request)
            } else {
                waitingTransporterSupportRequests.remove(at: index)
                approvedTransporterSupportRequests.append(request)
            }
        case .rejected:
            if status == .approve {
                rejectedTransporterSupportRequests.remove(at: index)
                approvedTransporterSupportRequests.append(request)
            }
        case .approved:
            if status == .reject {
                approvedTransporterSupportRequests.remove(at: index)
                rejectedTransporterSupportRequests.append(request)
            }
        }
    }
}
