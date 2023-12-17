//
//  SignupView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
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
            Task {
                await viewModel.getLocations()
            }
        }
        .onChange(of: viewModel.selectedCountry, perform: { _ in
            viewModel.updateLocations(
                countries: viewModel.countries,
                cities: viewModel.cities,
                districts: viewModel.districts)
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
        .alert("Kayıt olma işlemi başarısız oldu.", isPresented: $viewModel.unSuccessfulRegistration) {} message: {
            if let error = viewModel.authError {
                Text(error.description)
            }
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

    @ViewBuilder private func customCountryInputField(title: String, icon: String, countries: [Country], selection: Binding<Country>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: selection) {
                ForEach(countries, id: \.id) { country in
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

    @ViewBuilder private func customCityInputField(title: String, icon: String, cities: [City], selection: Binding<City>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: selection) {
                ForEach(cities, id: \.id) { city in
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

    @ViewBuilder private func customDistrictInputField(title: String, icon: String, districts: [District], selection: Binding<District>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(title, selection: selection) {
                ForEach(districts, id: \.id) { district in
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
                                    icon: "map.fill",
                                    countries: viewModel.countries,
                                    selection: $viewModel.selectedCountry)
            customCityInputField(title: "Şehir",
                                 icon: "map",
                                 cities: viewModel.cities,
                                 selection: $viewModel.selectedCity)
            customDistrictInputField(title: "İlçe",
                                     icon: "mappin",
                                     districts: viewModel.districts,
                                     selection: $viewModel.selectedDistrict)
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
        SignupView()
    }
}
