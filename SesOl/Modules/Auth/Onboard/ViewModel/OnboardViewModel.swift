//
//  OnBoardViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 23.04.2023.
//

import Foundation

final class OnboardViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var isHomeRedirect: Bool = false
    
    private let cache = UserDefaultCache()
    
    private func isUserFirstLogin() -> Bool {
        return cache.read(key: .onboard).isEmpty
    }
    
    func checkUserFirstTime() {
        //removeCacheFirstLogin()
        guard !isUserFirstLogin() else {
            updateCacheFirstLogin()
            return }
        redirectToHome()
    }
    
    func saveUserLoginAndRedirect() {
        updateCacheFirstLogin()
        redirectToHome()
    }
    
    private func redirectToHome() {
        isHomeRedirect = true
    }
    
    private func updateCacheFirstLogin() {
        return cache.save(key: .onboard, value: UserCacheKeys.dummyValue)
    }
    
    private func removeCacheFirstLogin() {
        return cache.remove(key: .onboard)
    }

}
