//
//  SesOlApp.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

@main
struct SesOlApp: App {
    @StateObject private var viewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if viewModel.alreadyLogged() {
                    RootView()
                } else {
                    OnboardView()
                }
            }
        }
    }
}
