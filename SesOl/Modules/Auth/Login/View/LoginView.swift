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
                    Icons.App.icon_dark.rawValue.toImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.dw(width: 0.7))
                    Text("Hoşgeldiniz")
                        .font(.system(size: FontSizes.title1, weight: .semibold))
                        .foregroundColor(.dark_liver)
                    HTextIconField(hint: "Telefon numarası", iconName: Icons.Auth.icon_tel.rawValue, text: $viewModel.userPhone)
                    HTextSecureIconField(hint: "Şifre", iconName: Icons.Auth.icon_lock.rawValue, text: $viewModel.userPassword)
                        .padding(.top, PagePaddings.Auth.normal.rawValue)

                    CustomButton(onTap: {
                        Task {
                            await viewModel.loginUser()
                        }
                    }, title: "Giriş yap")
                        .padding(.top, PagePaddings.Auth.normal.rawValue)

                    NavigationLink("", isActive: $viewModel.isLogged) {
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                    }

                    Group {
                        HStack {
                            Text("Hesabın yok mu?")
                            Button("Kaydol") {
                                viewModel.toSignup.toggle()
                            }
                                .foregroundColor(.blue)
                            NavigationLink("", isActive: $viewModel.toSignup) {
                                SignupView().navigationBarBackButtonHidden(true)

                            }
                        }
                            .padding(.top, PagePaddings.All.normal.rawValue)
                            .font(.system(size: FontSizes.caption1, weight: .regular))
                            .foregroundColor(.spanish_gray)
                            .tint(.brilliant_azure)
                    }
                    Divider().frame(width: 200)
                    Spacer()

                }
                    .padding(.all, PagePaddings.All.normal.rawValue)
            }
        }.modifier(ViewStatusHiddenModifier())
    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().ignoresSafeArea(.all)
    }
}

private struct HTextIconField: View {

    let hint: String
    let iconName: String
    var text: Binding<String>

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.black)
            TextField(hint, text: text)
                .foregroundColor(.spanish_gray)
        }.modifier(TextFieldModifier())
    }
}

private struct HTextSecureIconField: View {

    let hint: String
    let iconName: String
    var text: Binding<String>

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.black)
            SecureField(hint, text: text)
                .foregroundColor(.spanish_gray)
        }.modifier(TextFieldModifier())
    }
}
