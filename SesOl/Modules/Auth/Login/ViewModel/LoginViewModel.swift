//
//  LoginViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 24.04.2023.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID: Int = 0

    @Published var userPassword: String = ""
    @Published var userPhone: String = ""
    @Published var isLogged: Bool = false
    @Published var toSignup: Bool = false
    @Published var authErrorMessage: AuthError?

    let authService = AuthService()

    func loginUser() async {
        let response = await authService.login(phoneNumber: userPhone,
                                               password: userPassword)
        switch response {
        case .success(let success):
            if let userAccountID = success.userAccountID, let isUnionAccount = success.isUnionAccount {
                userType = UserType(rawValue: isUnionAccount) ?? .citizien
                userID = userAccountID
            }
        case .failure(let failure):
            DispatchQueue.main.async {
                self.authErrorMessage = failure
                self.isLogged = false
            }
        }
    }
}
