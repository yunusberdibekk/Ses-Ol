//
//  ProfileView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.05.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            VStack (spacing: 15) {
                Spacer()
                if profileViewModel.isUnionAccount == 1 {
                    HStack {
                        Spacer()
                        NavigationLink(isActive: $profileViewModel.showEdit) {
                            IbanDetailView().navigationBarBackButtonHidden(true)
                        } label: {
                            Button {
                                profileViewModel.showEdit.toggle()
                            } label: {
                                Image(systemName: "creditcard.fill")
                                    .foregroundColor(.halloween_orange)
                            }
                        }
                    }
                        .padding(.trailing, PagePaddings.Normal.padding_20.rawValue)
                }

                Image(systemName: profileViewModel.isUnionAccount == 0 ? "person.fill" : "person.badge.shield.checkmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)

                Text("Kullanıcı Bilgileri")
                    .font(.title)
                    .foregroundColor(.dark_liver)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)

                VStack(spacing: 10) {
                    if profileViewModel.isUnionAccount == 0 {
                        if let citizienProfile = profileViewModel.citizienModel {
                            UserInformationItem(iconName: "person.fill", text: citizienProfile.userName ?? "")
                            UserInformationItem(iconName: "person.fill", text: citizienProfile.userSurname ?? "")
                            UserInformationItem(iconName: "phone.fill", text: citizienProfile.userTel ?? "")
                            UserInformationItem(iconName: "map.circle.fill", text: citizienProfile.addressCountry ?? "")
                            UserInformationItem(iconName: "map.circle", text: citizienProfile.addressCity ?? "")
                            UserInformationItem(iconName: "mappin.circle.fill", text: citizienProfile.addressDistrict ?? "")
                            UserInformationItem(iconName: "mappin.circle", text: citizienProfile.fullAddress ?? "")
                        }
                    } else if profileViewModel.isUnionAccount == 1 {
                        if let unionProfile = profileViewModel.unionModel {
                            UserInformationItem(iconName: "person.fill", text: unionProfile.unionName ?? "")
                            UserInformationItem(iconName: "envelope.fill", text: unionProfile.unionEmail ?? "")
                            UserInformationItem(iconName: "globe", text: unionProfile.unionWebSite ?? "")
                            UserInformationItem(iconName: "phone.fill", text: unionProfile.unionTel ?? "")
                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .foregroundColor(.halloween_orange)

                                Picker("Kurum İbanlar", selection: .constant(0)) {
                                    Text("İbanlarım").tag(0)
                                    ForEach(profileViewModel.ibans, id: \.ibanID) { iban in
                                        HStack {
                                            Text(iban.ibanTitle ?? "")
                                            Text(iban.iban ?? "")
                                        }
                                            .foregroundColor(.spanish_gray)
                                    }
                                }
                                    .pickerStyle(.navigationLink)
                                    .foregroundColor(.gray.opacity(0.6))
                                Spacer()
                            }.modifier(TextFieldModifier())
                                .onAppear {
                                Task {
                                    await profileViewModel.readIbans()
                                }
                            }

                            Spacer().frame(height: 75)
                        }

                    } else {
                        Text("Error")
                    }
                }
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)

                NavigationLink(isActive: $profileViewModel.quit) {
                    LoginView().navigationBarBackButtonHidden(true)
                } label: {
                    Button {
                        profileViewModel.quitUserAcccount()
                    } label: {
                        Text("Çıkış")
                            .font(.system(size: FontSizes.headline))
                            .fontWeight(.regular)
                            .padding(.trailing, 0)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.halloween_orange)
                }
                Spacer().frame(height: 60)
            }
        }
            .onAppear {
            profileViewModel.readCache(userIdKey: .userId, isUnionKey: .isUnionAccount)
            Task {
                if profileViewModel.isUnionAccount == 0 {
                    await profileViewModel.readCitizien()
                } else {
                    await profileViewModel.readUnion()
                }
                await profileViewModel.readIbans()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

private struct UserInformationItem: View {
    var iconName: String
    var text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.dark_liver)
        }
            .modifier(TextFieldModifier())
    }
}
