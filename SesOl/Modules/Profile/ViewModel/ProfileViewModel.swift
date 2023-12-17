//
//  ProfileViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.05.2023.
//

import Foundation
import UIKit

final class ProfileViewModel: ObservableObject {
    @Published var citizien: CitizienProfileResponse? = nil
    @Published var union: UnionProfileResponse? = nil
    @Published var unionIbans: [IbanReadResponseElement] = []
    @Published var selectedIbanID: Int = 0
    @Published var ibanOption: IbanOptions = .create
    @Published var ibanTitle: String = ""
    @Published var ibanNo: String = ""
    @Published var logMessage: String = ""
    @Published var logStatus: Bool = false

    func readCitizien(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .usersCrud,
            method: .post,
            model: CitizienProfileRequest(
                method: RequestMethods.read_user.rawValue,
                user_account_id: id),
            type: CitizienProfileResponse.self)
        DispatchQueue.main.async {
            switch response {
            case .success(let model):
                self.citizien = model
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
    }

    func readUnion(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .unionsCrud,
            method: .post,
            model: UnionProfileRequest(
                method: RequestMethods.read_union.rawValue,
                user_account_id: id),
            type: UnionProfileResponse.self)
        DispatchQueue.main.async {
            switch response {
            case .success(let model):
                self.union = model
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
    }

    func readUnionIbans(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanReadRequest(
                method: RequestMethods.read_iban.rawValue,
                user_account_id: id),
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

    func createUnionIban(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanCreateRequest(
                method: RequestMethods.create_iban.rawValue,
                user_account_id: id,
                iban_title: ibanTitle,
                iban: ibanNo),
            type: IbanCreateResponse.self)
        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let response = success.status {
                    if response == "ok" {
                        self.logStatus = true
                    } else {
                        self.logStatus = false
                    }
                }
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
        await readUnionIbans(with: id)
    }

    func updateUnionIban(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanUpdateeRequest(
                method: RequestMethods.update_iban.rawValue,
                iban_id: selectedIbanID,
                iban_title: ibanTitle,
                iban: ibanNo),
            type: IbanUpdateResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let response):
                if let status = response.status {
                    if status == "ok" {
                        self.logStatus = true
                    } else {
                        self.logStatus = false
                    }
                }
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
        await readUnionIbans(with: id)
    }

    func deleteUnionIban(with id: Int) async {
        let response = await NetworkManager.shared.post(
            url: .ibanCrud,
            method: .post,
            model: IbanDeleteRequest(
                method: RequestMethods.delete_iban.rawValue,
                iban_id: selectedIbanID),
            type: IbanDeleteResponse.self)
        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let response = success.status {
                    if response == "ok" {
                        self.logStatus = true
                    } else {
                        self.logStatus = false
                    }
                }
            case .failure(let error):
                self.logMessage = error.localizedDescription
            }
        }
        await readUnionIbans(with: id)
    }

    func signOut() {
        // TODO: - @APPSTORAGE İLE OLANLARI SIFIRLA
        DispatchQueue.main.async {
            self.citizien = nil
            self.union = nil
        }
    }
}
