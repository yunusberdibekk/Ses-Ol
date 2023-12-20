//
//  SOCreateViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.12.2023.
//

import Foundation
import SwiftUI

final class SOCreateViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID: Int = 0

    /// Union
    @Published var posts: [UnionPostResponseElement] = []
    @Published var unionCreateViewOption: UnionCreateViewOptions = .createPost
    /// Citizien
    @Published var citizienCreateViewRequestType: RequestTypes = .help
    @Published var unions: UnionResponse = []
    @Published var selectedUnion: UnionResponseElement? = nil
    @Published var disasters: DisasterResponse = []
    @Published var selectedDisaster: DisasterResponseElement? = nil
    @Published var helpRequestCategories: HelpRequestCategoriesResponse = []
    @Published var selectedHelpRequestType: HelpRequestCategoryResponseElement? = nil
    @Published var selectedRequestType: RequestTypes = .help
    @Published var selectedSupportRequestType: SupportRequestTypes = .standart

    @Published var postDesc: String = ""
    @Published var vehicleStatus: Bool = false
    @Published var numOfPersons: Int = 0
    @Published var requestDesc: String = ""
    @Published var requestTitle: String = ""
    @Published var citizienAdresID: Int? = nil
    @Published var fromLocation: String = ""
    @Published var toLocation: String = ""
    @Published var numOfCars: String = ""
    @Published var numOfDrivers: String = ""
    @Published var logStatus: Bool = false
    @Published var logMessage: String = ""

    /// CİTİZİEN CREATE POST VİEW

    func resetProperties() {}

    // MARK: - Union

    func canDelete(unionID: Int) -> Bool {
        return userID == unionID && userType == .union
    }

    func fetchAdditionalUnionPosts() async {
        guard userType == .union else { return }

        let result = await NetworkManager.shared.post(
            url: .unionPostCrud,
            method: .post,
            model: UnionPostRequest(
                method: RequestMethods.read_post.rawValue),
            type: [UnionPostResponseElement].self)

        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.posts = models.filter { $0.publisherUnionID == self.userID }
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func createUnionPost() async {
        guard !postDesc.isEmpty else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .unionPostCrud,
            method: .post,
            model: CreatePostRequest(
                method: RequestMethods.create_post.rawValue,
                post_publisher_id: userID,
                post_content: postDesc),
            type: CreatePostResponse.self)

        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Gönderi başarıyla oluşturuldu.")
            } else {
                await showMessage(message: "Gönderi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func deleteUnionPost(postID: Int, index: Int) async {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .unionPostCrud,
            method: .post,
            model: DeletePostRequest(
                method: RequestMethods.delete_post.rawValue,
                post_id: postID),
            type: DeletePostResponse.self)

        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Silme işlemi başarıyla gerçekleşti.")
                await deleteRequestAtList(index)
            } else {
                await showMessage(message: "Gönderi silinirken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    // MARK: - Citizien

    func createRequest() async {
        switch selectedRequestType {
        case .help:
            Task {
                await createHelpRequest()
            }
        case .support:
            Task {
                switch selectedSupportRequestType {
                case .standart:
                    await createStandartSupportRequest()
                case .psyhlogist:
                    await createPsychologistRequest()
                case .pitchtent:
                    await createPitchTentRequest()
                case .transporter:
                    await createTransporterRequest()
                }
            }
        }
    }

    private func fetchCitizienAdress() async {
        let result = await NetworkManager.shared.post(
            url: .usersCrud,
            method: .post,
            model: CitizienProfileRequest(
                method: RequestMethods.read_user.rawValue,
                user_account_id: userID),
            type: CitizienProfileResponse.self)
        switch result {
        case .success(let model):
            citizienAdresID = model.addressID
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func fetchUnions() async {
        let result = await NetworkManager.shared.post(
            url: .unionsCrud,
            method: .post,
            model: UnionRequest(
                method: RequestMethods.get_all_unions.rawValue),
            type: UnionResponse.self)

        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.unions = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func fetchHelpRequestCategories() async {
        let result = await NetworkManager.shared.fetch(
            url: .getRequirement,
            method: .get,
            type: HelpRequestCategoriesResponse.self)

        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.helpRequestCategories = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func fetchDisasters() async {
        let result = await NetworkManager.shared.fetch(
            url: .getDisaster,
            method: .get,
            type: DisasterResponse.self)

        switch result {
        case .success(let models):
            DispatchQueue.main.async {
                self.disasters = models
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    private func createHelpRequest() async {
        guard let selectedUnion = selectedUnion, let selectedDisaster = selectedDisaster, let selectedHelpRequestType = selectedHelpRequestType else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .requestCrud,
            method: .post,
            model: CreateUserRequest(
                method: RequestMethods.create_request.rawValue,
                request_account_id: userID,
                num_of_person: numOfPersons,
                request_disaster_id: selectedDisaster.disasterID,
                request_union_id: selectedUnion.id,
                request_category: selectedHelpRequestType.categoryID,
                request_desc: requestDesc),
            type: CreateUserHelpRequestResponse.self)

        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Yardım talebi başarıyla oluşturuldu.")
                resetProperties()
            } else {
                await showMessage(message: "Destek talebi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    private func createStandartSupportRequest() async {
        await fetchCitizienAdress()
        guard let selectedUnion = selectedUnion, let selectedHelpRequestType = selectedHelpRequestType, let citizienAdresID = citizienAdresID else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .providingAssistanceCrud,
            method: .post,
            model: CreateSupportRequest(
                method: RequestMethods.create_assistance.rawValue,
                user_assistance_account_id: userID,
                assistance_title: requestTitle,
                assistance_sent_union_id: selectedUnion.id,
                assistance_num_of_person: numOfPersons,
                assistance_category_id: selectedHelpRequestType.categoryID,
                assistance_desc: requestDesc,
                assistance_address_id: citizienAdresID,
                is_a_union: userType.rawValue),
            type: CreateUserHelpRequestResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Destek talebi başarıyla oluşturuldu.")
                resetProperties()
            } else {
                await showMessage(message: "Yardım talebi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func createPsychologistRequest() async {
        await fetchCitizienAdress()
        guard let selectedUnion = selectedUnion else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPsychologist,
            method: .post,
            model: CreateVoluntarilyPsychologistRequest(
                method: RequestMethods.create_voluntarily.rawValue,
                user_account_id: userID,
                voluntarily_union_id: selectedUnion.id,
                voluntarily_vehicle_status: vehicleStatus ? 1 : 0,
                voluntarily_desc: requestDesc),
            type: CreateVoluntarilyPsychologistResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Yardım talebi başarıyla oluşturuldu.")
                resetProperties()
            } else {
                await showMessage(message: "Yardım talebi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func createPitchTentRequest() async {
        guard let selectedUnion = selectedUnion else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyPitchTent,
            method: .post,
            model: CreateVoluntarilyPitchTentRequest(
                method: RequestMethods.create_voluntarily.rawValue,
                user_account_id: userID,
                voluntarily_union_id: selectedUnion.id,
                voluntarily_vehicle_status: vehicleStatus ? 1 : 0,
                voluntarily_description: requestDesc),
            type: CreateVoluntarilyPsychologistResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Yardım talebi başarıyla oluşturuldu.")
                resetProperties()
            } else {
                await showMessage(message: "Yardım talebi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
            }
        case .failure(let error):
            await showMessage(message: error.localizedDescription)
        }
    }

    func createTransporterRequest() async {
        guard let selectedUnion = selectedUnion, let numOfCars = Int(numOfCars), let numOfDrivers = Int(numOfDrivers) else {
            await showMessage(message: "Lütfen ilgili tüm alanları doldurunuz.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .voluntarilyTransporter,
            method: .post,
            model: CreateVoluntarilyTransporterRequest(
                method: RequestMethods.create_voluntarily.rawValue,
                user_account_id: userID,
                union_id: selectedUnion.id,
                voluntarily_from_location: fromLocation,
                voluntarily_to_location: toLocation,
                voluntarily_num_of_vehicle: numOfCars,
                voluntarily_num_of_driver: numOfDrivers,
                voluntarily_description: requestDesc),
            type: CreateVoluntarilyTransporterResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showMessage(message: "Yardım talebi başarıyla oluşturuldu.")
                resetProperties()
            } else {
                await showMessage(message: "Yardım talebi oluşturulurken bir hata meydana geldi. Lütfen tekrar deneyin.")
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
    private func deleteRequestAtList(_ index: Int) {
        posts.remove(at: index)
    }
}
