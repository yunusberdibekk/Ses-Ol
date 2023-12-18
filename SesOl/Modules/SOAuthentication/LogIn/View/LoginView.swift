//
//  LoginView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    headerView(width: geometry.dw(width: 0.7))
                    customInputField(title: "Telefon numarası",
                                     icon: "phone.fill",
                                     text: $viewModel.userPhone,
                                     isTextField: true)
                    customInputField(title: "Şifre",
                                     icon: "lock.fill",
                                     text: $viewModel.userPassword,
                                     isTextField: false)
                        .padding(.top, PagePaddings.Auth.normal.rawValue)
                    customFooterView()
                    Spacer()
                }
                .navigationDestination(isPresented: $viewModel.toSignup, destination: {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                })
                .navigationDestination(isPresented: $viewModel.isLogged, destination: {
                    SORootView()
                        .navigationBarBackButtonHidden(true)
                })
                .padding(.all, PagePaddings.All.normal.rawValue)
            }
        }
        .modifier(ViewStatusHiddenModifier())
        .alert("Dikkat!", isPresented: $viewModel.logStatus) {
            Text(viewModel.logMessage)
        }
    }

    private func headerView(width: CGFloat) -> some View {
        VStack(spacing: 0) {
            Icons.App.icon_dark.rawValue.toImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
            Text("Hoşgeldiniz")
                .font(.system(size: FontSizes.title1, weight: .semibold))
                .foregroundColor(.dark_liver)
        }
    }

    @ViewBuilder private func customInputField(title: String, icon: String, text: Binding<String>, isTextField: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            if isTextField {
                TextField(title, text: text)
            } else {
                SecureField(title, text: text)
            }
        }
        .foregroundColor(.gray.opacity(0.6))
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func customFooterView() -> some View {
        CustomButton(onTap: {
            Task { await viewModel.loginUser() }
        }, title: "Giriş yap")
            .padding(.top, PagePaddings.Auth.normal.rawValue)

        HStack {
            Text("Hesabın yok mu?")
            Button("Kaydol") {
                viewModel.toSignup = true
            }
            .foregroundColor(.blue)
        }
        .padding(.top, PagePaddings.All.normal.rawValue)
        .font(.system(size: FontSizes.caption1, weight: .regular))
        .foregroundColor(.spanish_gray)
        .tint(.brilliant_azure)
        Divider().frame(width: 200)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .ignoresSafeArea(.all)
    }
}
