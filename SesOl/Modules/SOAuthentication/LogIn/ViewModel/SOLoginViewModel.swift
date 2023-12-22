//
//  LoginViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 24.04.2023.
//

import SwiftUI

final class SOLoginViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID: Int = 0

    @Published var userPassword: String = ""
    @Published var userPhone: String = ""
    @Published var isLogged: Bool = false
    @Published var toSignup: Bool = false
    @Published var logMessage: String = ""
    @Published var logStatus: Bool = false

    func loginUser() async {
        let response = await NetworkManager.shared.post(
            url: .login,
            method: .post,
            model: LoginRequest(
                user_tel: userPhone,
                user_password: userPassword),
            type: LoginResponse.self)
        switch response {
        case .success(let model):
            DispatchQueue.main.async {
                self.userType = UserType(rawValue: model.isUnionAccount) ?? .citizien
                self.userID = model.userAccountID
                self.isLogged = true
            }

        case .failure(let error):
            showAlert(message: error.localizedDescription)
        }
    }

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            self.logMessage = message
            self.logStatus.toggle()
        }
    }

    private func isValidateValues() -> Bool {
        guard userPhone.isValidPhone else {
            showAlert(message: "Telefon uzunluğu min. 8 olmalıdır.Özel karakterler içermemelidir.Ülke alan kodunu içermelidir.")
            return false
        }

        guard userPassword.count > 6 else {
            showAlert(message: "Kullanıcı şifresi min. 6 olmalıdır.")
            return false
        }
        return true
    }
}
