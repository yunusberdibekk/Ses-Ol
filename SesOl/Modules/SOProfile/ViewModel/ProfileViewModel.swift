//
//  ProfileViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.05.2023.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID = 0
    @Published var citizien: CitizienProfileResponse? = nil
    @Published var union: UnionProfileResponse? = nil

    @Published var unionIbans: [IbanReadResponseElement] = []
    @Published var selectedIbanID: Int = 0

    @Published var ibanNo: String = ""
    @Published var ibanTitle: String = ""

    @Published var logMessage: String = ""
    @Published var logStatus: Bool = false

    @Published var ibans: [IbanReadResponseElement] = [
        .init(id: 1, userAccountID: 1, ibanTitle: "Ziraat Bankası", iban: UUID().uuidString),
        .init(id: 2, userAccountID: 1, ibanTitle: "Halk Bankası", iban: UUID().uuidString),
        .init(id: 3, userAccountID: 1, ibanTitle: "Vakıf Bank", iban: UUID().uuidString),
        .init(id: 4, userAccountID: 1, ibanTitle: "İş Bankası", iban: UUID().uuidString),
        .init(id: 5, userAccountID: 1, ibanTitle: "Ing Bank", iban: UUID().uuidString),
    ]

    @MainActor
    private func showAlert(message: String) {
        logMessage = message
        logStatus.toggle()
    }

    func resetProperties() {}

    func readCitizien() async {
        let result = await NetworkManager.shared.post(
            url: .usersCrud,
            method: .post,
            model: CitizienProfileRequest(
                method: RequestMethods.read_user.rawValue,
                user_account_id: userID),
            type: CitizienProfileResponse.self)
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                self.citizien = model
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func readUnion() async {
        let result = await NetworkManager.shared.post(
            url: .unionsCrud,
            method: .post,
            model: UnionProfileRequest(
                method: RequestMethods.read_union.rawValue,
                user_account_id: userID),
            type: UnionProfileResponse.self)
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                self.union = model
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func readUnionIbans() async {
        let response = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanReadRequest(
                method: RequestMethods.read_iban.rawValue,
                user_account_id: userID),
            type: [IbanReadResponseElement].self)
        DispatchQueue.main.async {
            switch response {
            case .success(let models):
                self.unionIbans = models
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
    }

    func createUnionIban() async {
        guard userType == .union else { return }
        guard !ibanTitle.isEmpty, !ibanNo.isEmpty else {
            await showAlert(message: "Lütfen ilgili tüm alanları doldurun.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanCreateRequest(
                method: RequestMethods.create_iban.rawValue,
                user_account_id: userID,
                iban_title: ibanTitle,
                iban: ibanNo),
            type: IbanCreateResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showAlert(message: "İban başarıyla oluşturulmuştur.")
            } else {
                await showAlert(message: "İban oluşturma işleminde bir hata meydana gelmiştir. Lütfen daha sonra tekrar deneyiniz")
            }
        case .failure(let error):
            await showAlert(message: error.localizedDescription)
        }
    }

    func updateUnionIban(ibanID: Int) async {
        guard userType == .union else { return }
        guard !ibanTitle.isEmpty, !ibanNo.isEmpty else {
            await showAlert(message: "Lütfen ilgili tüm alanları doldurun.")
            return
        }
        let result = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanUpdateeRequest(
                method: RequestMethods.update_iban.rawValue,
                iban_id: ibanID,
                iban_title: ibanTitle,
                iban: ibanNo),
            type: IbanUpdateResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showAlert(message: "Güncelleme işlemi başarıyla gerçekleştir.")
            } else {
                await showAlert(message: model.msg)
            }
        case .failure(let error):
            await showAlert(message: error.localizedDescription)
        }
    }

    func deleteUnionIban(ibanID: Int, index: Int) async {
        guard userType == .union else { return }
        let result = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanDeleteRequest(
                method: RequestMethods.delete_iban.rawValue,
                iban_id: ibanID),
            type: IbanDeleteResponse.self)
        switch result {
        case .success(let model):
            if model.status == "ok" {
                await showAlert(message: "Güncelleme işlemi başarıyla gerçekleştir.")
                unionIbans.remove(at: index)
            } else {
                await showAlert(message: model.msg)
            }
        case .failure(let error):
            await showAlert(message: error.localizedDescription)
        }
    }

    func signOut() {
        // TODO: - @APPSTORAGE İLE OLANLARI SIFIRLA
        DispatchQueue.main.async {
            self.citizien = nil
            self.union = nil
            self.userID = 0
        }
    }
}
