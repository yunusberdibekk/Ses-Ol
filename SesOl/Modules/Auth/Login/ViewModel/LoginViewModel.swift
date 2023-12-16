//
//  LoginViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 24.04.2023.
//

import Alamofire
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var userPhone: String = ""
    @Published var userPassword: String = ""

    @Published var isLogged = false
    @Published var toSignup = false
    @Published var authErrorMessage: AuthError?

    let authService = AuthService()
    private let cache = UserDefaultCache()

    func loginUser() async {
        let response = await authService.login(phoneNumber: userPhone, password: userPassword)

        switch response {
        case .success(let success):
            if let userAccountID = success.userAccountID, let isUnionAccount = success.isUnionAccount {
                await onSaveUserToken(userID: String(userAccountID), isUnion: String(isUnionAccount))
            }
        case .failure(let failure):
            DispatchQueue.main.async {
                self.authErrorMessage = failure
                self.isLogged = false
            }
        }
    }

    func onSaveUserToken(userID: String, isUnion: String) async {
        cache.save(key: .userId, value: userID)
        cache.save(key: .isUnionAccount, value: isUnion)

        DispatchQueue.main.async {
            self.isLogged = true
        }
    }

    func alreadyLogged() -> Bool {
        return !cache.read(key: .userId).isEmpty
    }
}
