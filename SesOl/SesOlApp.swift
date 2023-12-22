//
//  SesOlApp.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

@main
struct SesOlApp: App {
    @AppStorage("isOnBoarding") var isOnBoarding = false

    var body: some Scene {
        WindowGroup {
//            if isOnBoarding {
//                LoginView()
//            } else {
//                OnboardView()
//            }
            SORootView()
        }
    }
}
