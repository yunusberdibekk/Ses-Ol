//
//  SignUpView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack {
                headerView
                switch viewModel.userType {
                case .citizien:
                    citizienInputList()
                case .union:
                    unionInputList()
                }
                CustomButton(onTap: {
                    Task {
                        await viewModel.signUp()
                    }
                }, title: "Kayıt ol")
                    .padding(.top, PagePaddings.All.normal.rawValue)
                Spacer()
            }
            .padding(.all, PagePaddings.All.normal.rawValue)
        }
        .onAppear {
//            Asıl bu olacak.
//            Task {
//                await viewModel.getLocations()
//            }
            Task {
                viewModel.updateMockLocations()
            }
        }
        .onChange(of: viewModel.selectedCountry, perform: { _ in
            Task {
                viewModel.updateLocations()
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.halloween_orange)
                }
            }
        }
        .alert("Dikkat!", isPresented: $viewModel.logStatus) {
            Text(viewModel.logMessage)
        }
    }

    private var headerView: some View {
        VStack {
            Text("Kayıt Ol")
                .font(.system(.title, weight: .bold))
                .foregroundColor(.halloween_orange)
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker("Seç", selection: $viewModel.userType) {
                ForEach(UserType.allCases, id: \.self) { item in
                    Text(item.description)
                }
            }
            .tint(.halloween_orange)
            .pickerStyle(.segmented)
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

    @ViewBuilder private func customCountryInputField(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: $viewModel.selectedCountry) {
                ForEach(viewModel.countries, id: \.id) { country in
                    Text(country.ulkeAdi)
                        .tag(country)
                }
            }
            .pickerStyle(.navigationLink)
            .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func customCityInputField(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: $viewModel.selectedCity) {
                ForEach(viewModel.cities, id: \.self) { city in
                    Text(city.sehirAdi)
                        .tag(city)
                }
            }
            .pickerStyle(.navigationLink)
            .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func customDistrictInputField(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: $viewModel.selectedDistrict) {
                ForEach(viewModel.districts, id: \.self) { district in
                    Text(district.ilceAdi)
                        .tag(district)
                }
            }
            .pickerStyle(.navigationLink)
            .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func citizienInputList() -> some View {
        VStack(spacing: 15) {
            customInputField(title: "Ad",
                             icon: "person.fill",
                             text: $viewModel.citizienName,
                             isTextField: true)
            customInputField(title: "Soyad",
                             icon: "person",
                             text: $viewModel.citizienSurname,
                             isTextField: true)
            customInputField(title: "Telefon numarası",
                             icon: "phone.fill",
                             text: $viewModel.citizienPhone,
                             isTextField: true)
            customCountryInputField(title: "Ülke",
                                    icon: "map.fill")
            customCityInputField(title: "Şehir",
                                 icon: "map")
            customDistrictInputField(title: "İlçe",
                                     icon: "mappin")
            customInputField(title: "Tam adres",
                             icon: "mappin.and.ellipse",
                             text: $viewModel.citizienFullAddress,
                             isTextField: true)
            customInputField(title: "Şifre",
                             icon: "lock.fill",
                             text: $viewModel.citizienFullAddress,
                             isTextField: false)
        }
        .padding(.top, PagePaddings.Auth.normal.rawValue)
    }

    @ViewBuilder private func unionInputList() -> some View {
        VStack(spacing: 15) {
            customInputField(title: "Kurum adı",
                             icon: "person.fill",
                             text: $viewModel.unionName,
                             isTextField: true)
            customInputField(title: "Telefon numarası",
                             icon: "phone.fill",
                             text: $viewModel.unionPhone,
                             isTextField: true)
            customInputField(title: "Email adresi",
                             icon: "envelope.fill",
                             text: $viewModel.unionEmail,
                             isTextField: true)
            customInputField(title: "Web sitesi",
                             icon: "network",
                             text: $viewModel.unionWebsite,
                             isTextField: true)
            customInputField(title: "Şifre",
                             icon: "lock.fill",
                             text: $viewModel.unionPassword,
                             isTextField: false)
        }
        .padding(.top, PagePaddings.Auth.normal.rawValue)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView()
        }
    }
}
