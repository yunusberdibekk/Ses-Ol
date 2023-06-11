//
//  LoginViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 24.04.2023.
//

import Foundation
import Alamofire

final class LoginViewModel: ObservableObject {
    @Published var userPhone: String = ""
    @Published var userPassword: String = ""

    @Published var isLogged = false
    @Published var toSignup = false

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func loginUser() async {
        let (userId, isUnionAccount) = await onLoginUser(userPhoneValue: userPhone, userPasswordValue: userPassword)

        if userId != -1 {
            await onSaveUserToken(userID: String(userId), isUnion: String(isUnionAccount))
        } else {
            DispatchQueue.main.async {
                self.isLogged = false
            }
        }
    }
}

extension LoginViewModel: ILoginViewModel {

    func onLoginUser(userPhoneValue: String, userPasswordValue: String) async -> (Int, Int) {
        guard !userPhoneValue.isEmpty else { return (-1, -1) }
        guard !userPasswordValue.isEmpty else { return (-1, -1) }

        let response = await networkManager.post(path: .login, model: LoginRequest(user_tel: userPhoneValue, user_password: userPasswordValue), type: LoginResponse.self)

        let userId: Int = response?.userAccountID ?? -1
        let isUnionAccount: Int = response?.isUnionAccount ?? -1

        return (userId, isUnionAccount)
    }

    func onSaveUserToken(userID: String, isUnion: String) async -> Void {
        cache.save(key: .userId, value: userID)
        cache.save(key: .isUnionAccount, value: isUnion)

        DispatchQueue.main.async {
            self.isLogged = true
        }
    }

    //Bunun sayesinde uygulama açıldığında direkt login view'a girmesine gerek yok.
    func alreadyLogged() -> Bool {
        return !cache.read(key: .userId).isEmpty
    }


}

protocol ILoginViewModel {
    func onLoginUser(userPhoneValue: String, userPasswordValue: String) async -> (Int, Int)
    func onSaveUserToken(userID: String, isUnion: String) async -> Void
    func alreadyLogged() -> Bool
}
