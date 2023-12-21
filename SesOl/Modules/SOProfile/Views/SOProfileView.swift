//
//  ProfileView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.05.2023.
//

import SwiftUI

struct SOProfileView: View {
    @StateObject var viewModel = SOProfileViewModel()
    @State var showIbans: Bool = false

    var body: some View {
        NavigationStack {
            switch viewModel.userType {
            case .citizien:
                if let citizien = viewModel.citizien {
                    citizienView(citizien: citizien)
                } else {
                    citizienView(citizien: CitizienProfileResponse.mockCitizienProfileResponseElement)
                }
            case .union:
                if let union = viewModel.union {
                    unionView(union: union)
                } else {
                    unionView(union: UnionProfileResponse.mockUnionProfileResponseElement)
                }
            }
        }
        .onAppear {
            Task {
                switch viewModel.userType {
                case .citizien:
                    await viewModel.readCitizien()
                case .union:
                    await viewModel.readUnion()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func citizienView(citizien: CitizienProfileResponse) -> some View {
        List {
            userInformationCell(
                text: citizien.userName,
                header: "Ad")
            userInformationCell(
                text: citizien.userSurname,
                header: "Soyad")
            userInformationCell(
                text: citizien.userTel,
                header: "Telefon numarası")
            userInformationCell(
                text: citizien.addressCountry,
                header: "Ülke")
            userInformationCell(
                text: citizien.addressCity,
                header: "Şehir")
            userInformationCell(
                text: citizien.addressDistrict,
                header: "İlçe")
            userInformationCell(
                text: citizien.fullAddress,
                header: "Açık adres")
            signOutButton
        }
        .navigationTitle("Kullanıcı Bilgileri")
    }

    private func unionView(union: UnionProfileResponse) -> some View {
        List {
            userInformationCell(text: union.unionName, header: "Kurum adı")
            userInformationCell(text: union.unionTel, header: "Telefon")
            userInformationCell(text: union.unionEmail, header: "Email")
            userInformationCell(text: union.unionWebSite, header: "Website")
            showIbansView
            signOutButton
        }
        .navigationTitle("Kullanıcı Bilgileri")
    }

    @ViewBuilder private func userInformationCell(text: String, header: String) -> some View {
        Section {
            Text(text)
        } header: {
            Text(header)
        }
    }

    private var showIbansView: some View {
        Section {
            Button("İbanları Listele") {
                showIbans.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        } header: {
            Text("Ibanlarım")
        }
        .sheet(isPresented: $showIbans, content: {
            SOProfileIbanView()
                .environmentObject(viewModel)
        })
    }

    private var signOutButton: some View {
        NavigationLink {
            LoginView()
                .navigationBarBackButtonHidden(true)
        } label: {
            Button("Çıkış") {
                viewModel.signOut()
            }
            .modifier(DefaultListButtonModifier(backgroundColor: .blue))
        }
    }
}

#Preview {
    SOProfileView()
}
