//
//  ProfileView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.05.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                switch userType {
                case .citizien:
                    headerView
                case .union:
                    unionIbansView()
                    headerView
                }
                signOutView
                Spacer()
                    .frame(height: 60)
            }
            .onAppear {
                Task {
                    switch userType {
                    case .citizien:
                        await viewModel.readCitizien(with: userID)
                    case .union:
                        await viewModel.readUnion(with: userID)
                        await viewModel.readUnionIbans(with: userID)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var editIbanView: some View {
        HStack(spacing: 0) {
            Spacer()
            NavigationLink {
                IbanDetailView()
                    .environmentObject(viewModel)
            } label: {
                Image(systemName: "creditcard.fill")
                    .foregroundStyle(.orange)
            }
        }
        .padding(.trailing, 20)
    }

    private var signOutView: some View {
        NavigationLink {
            LoginView()
                .navigationBarBackButtonHidden(true)
        } label: {
            Button {
                viewModel.signOut()
            } label: {
                Text("Çıkış")
                    .font(.system(size: FontSizes.headline))
                    .fontWeight(.regular)
                    .padding(.trailing, 0)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.halloween_orange)
        }
    }

    private var headerView: some View {
        VStack(spacing: 0) {
            Image(systemName: userType == .citizien ?
                "person.fill" : "person.badge.shield.checkmark.fill")
                .font(.largeTitle)
            Text("Kullanıcı Bilgileri")
                .font(.title)
                .foregroundColor(.gray)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 5)
        }
    }

    @ViewBuilder private func citizienInformationsView() -> some View {
        if let citizien = viewModel.citizien {
            VStack(spacing: 10) {
                userInformationCell(icon: "person.fill", title: citizien.userName ?? "")
                userInformationCell(icon: "person.fill", title: citizien.userSurname ?? "")
                userInformationCell(icon: "phone.fill", title: citizien.userTel ?? "")
                userInformationCell(icon: "map.circle.fill", title: citizien.addressCountry ?? "")
                userInformationCell(icon: "map.circle", title: citizien.addressCity ?? "")
                userInformationCell(icon: "mappin.circle.fill", title: citizien.addressDistrict ?? "")
                userInformationCell(icon: "mappin.circle", title: citizien.fullAddress ?? "")
            }
            .padding(.top, 10)
            .padding([.leading, .trailing], 20)
        }
    }

    @ViewBuilder private func unionInformationsView() -> some View {
        if let union = viewModel.union {
            VStack(spacing: 10) {
                userInformationCell(icon: "person.fill", title: union.unionName ?? "")
                userInformationCell(icon: "envelope.fill", title: union.unionEmail ?? "")
                userInformationCell(icon: "globe", title: union.unionWebSite ?? "")
                userInformationCell(icon: "phone.fill", title: union.unionTel ?? "")
                unionIbansView()
                Spacer()
                    .frame(height: 75)
            }
            .padding(.top, 10)
            .padding([.leading, .trailing], 20)
        }
    }

    @ViewBuilder private func unionIbansView() -> some View {
        HStack {
            Image(systemName: "creditcard.fill")
                .foregroundStyle(.orange)
            Picker("Ibanlar", selection: .constant("")) {
                ForEach(viewModel.unionIbans, id: \.ibanID) { iban in
                    HStack {
                        Text(iban.ibanTitle ?? "")
                        Text(iban.iban ?? "")
                    }
                    .foregroundColor(.spanish_gray)
                }
                .pickerStyle(.navigationLink)
                .foregroundColor(.gray.opacity(0.6))
            }
            Spacer()
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func userInformationCell(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange)
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.dark_liver)
        }
        .modifier(TextFieldModifier())
    }
}
