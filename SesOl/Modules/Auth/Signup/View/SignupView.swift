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
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Kayıt Ol")
                        .font(.title)
                        .foregroundColor(.halloween_orange)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                    .padding([.top, .trailing], PagePaddings.Normal.padding_20.rawValue)

                Picker("", selection: $viewModel.selectedOption) {
                    Text("Vatandaş")
                        .tag(0)
                    Text("Kurum")
                        .tag(1)
                }
                    .tint(.halloween_orange)
                    .pickerStyle(.segmented)

                if viewModel.selectedOption == 0 {
                    ScrollView {
                        VStack(spacing: 15) {
                            HTextIconField(text: $viewModel.citizienName, iconName: "person.fill", hint: "Ad")
                            HTextIconField(text: $viewModel.citizienSurname, iconName: "person.fill", hint: "Soyad")
                            HTextIconField(text: $viewModel.citizienPhone, iconName: "phone.fill", hint: "Telefon numarası")

                            HLocationCountryField(iconName: "map.circle.fill", hint: "Ülke", selectedItem: $viewModel.selectedCountry, countries: viewModel.countries)
                            HLocationCityField(iconName: "map.circle", hint: "Şehir", selectedItem: $viewModel.selectedCity, cities: viewModel.cities)
                            HLocationDistrictField(iconName: "mappin.circle.fill", hint: "İlçe", selectedItem: $viewModel.selectedDistrict, districts: viewModel.districts)

                            HTextIconField(text: $viewModel.citizienFullAddress, iconName: "mappin.circle", hint: "Tam adres")

                            HTextSecureIconField(text: $viewModel.citizienPassword, iconName: "lock.fill", hint: "Şifre")
                        } .padding(.top, PagePaddings.Auth.normal.rawValue)
                    }
                } else {
                    VStack(spacing: 15) {
                        HTextIconField(text: $viewModel.unionName, iconName: "person.fill", hint: "Kurum adı")
                        HTextIconField(text: $viewModel.unionPhone, iconName: "phone.fill", hint: "Telefon numarası")
                        HTextIconField(text: $viewModel.unionEmail, iconName: "envelope.fill", hint: "Email adresi")
                        HTextIconField(text: $viewModel.unionWebsite, iconName: "network", hint: "Web sitesi")
                        HTextSecureIconField(text: $viewModel.unionPassword, iconName: "lock.fill", hint: "Şifre")
                    }
                        .padding(.top, PagePaddings.Auth.normal.rawValue)
                }

                CustomButton(onTap: {
                    Task {
                        if viewModel.selectedOption == 0 {
                            await viewModel.signupCitizien()
                        } else {
                            await viewModel.signupUnion()
                        }
                    }

                }, title: "Kayıt ol")
                    .padding(.top, PagePaddings.All.normal.rawValue)
                Spacer()
            }
                .padding(.all, PagePaddings.All.normal.rawValue)

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
                .onAppear {
                Task {
                    await viewModel.getLocations()
                }
            }
                .onChange(of: viewModel.selectedCountry, perform: { newValue in
                viewModel.selectedCity = City(sehir_id: "-1", sehir_adi: "Seç", ulke_idfk: "-1")
                viewModel.selectedDistrict = District(ilce_id: "-1", ilce_adi: "Seç", sehir_idfk: "-1")
            })
                .alert("Kayıt olma işlemi başarısız oldu.", isPresented: $viewModel.unSuccessfulRegistration) {
                Button("Tamam") {
                    print("Kayıt olma başarısız.")
                }
            } message: {
                if let error = viewModel.authError {
                    Text(error.description)
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

private struct HTextIconField: View {
    var text: Binding<String>
    var iconName: String
    let hint: String
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange.opacity(0.5))
            TextField(hint, text: text)

        } .foregroundColor(.gray.opacity(0.60))

            .modifier(TextFieldModifier())
    }
}

private struct HTextSecureIconField: View {
    var text: Binding<String>
    var iconName: String
    let hint: String
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange.opacity(0.5))
            SecureField(hint, text: text)
        } .foregroundColor(.gray.opacity(0.60))

            .modifier(TextFieldModifier())
    }
}

private struct HLocationCountryField: View {
    var iconName: String
    var hint: String

    @Binding var selectedItem: Country

    var countries: [LocationResponseElement]

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange.opacity(0.5))
            Picker(hint, selection: $selectedItem) {
                Text("Seç").tag(Country(ulke_id: "-1", ulke_adi: "Seç"))
                ForEach(countries, id: \.ulkeID) { element in
                    let country = Country(ulke_id: element.ulkeID ?? "", ulke_adi: element.ulkeAdi ?? "")
                    Text(element.ulkeAdi ?? "").tag(country)
                }
            }
                .pickerStyle(.navigationLink)
                .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
            .modifier(TextFieldModifier())
    }
}

private struct HLocationCityField: View {
    var iconName: String
    var hint: String

    @Binding var selectedItem: City

    var cities: [LocationResponseElement]
    @StateObject private var viewModel = SignupViewModel()
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange.opacity(0.5))

            Picker(hint, selection: $selectedItem) {
                Text("Seç").tag(City(sehir_id: "-1", sehir_adi: "Seç", ulke_idfk: "-1"))
                ForEach(cities, id: \.self) { element in
                    let city = City(sehir_id: element.sehirID ?? "", sehir_adi: element.sehirAdi ?? "", ulke_idfk: element.ulkeIDFk ?? "")
                    Text(element.sehirAdi ?? "").tag(city)
                }
            }
                .pickerStyle(.navigationLink)
                .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
            .modifier(TextFieldModifier())
    }
}

private struct HLocationDistrictField: View {
    var iconName: String
    var hint: String

    @Binding var selectedItem: District

    var districts: [LocationResponseElement]
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.halloween_orange.opacity(0.5))

            Picker(hint, selection: $selectedItem) {
                Text("Seç").tag(District(ilce_id: "-1", ilce_adi: "Seç", sehir_idfk: "-1"))
                ForEach(districts, id: \.ilceID) { element in
                    let district = District(ilce_id: element.ilceID ?? "", ilce_adi: element.ilceAdi ?? "", sehir_idfk: element.sehirIDFk ?? "")
                    Text(element.ilceAdi ?? "").tag(district)
                }
            }
                .pickerStyle(.navigationLink)
                .foregroundColor(.gray.opacity(0.6))
            Spacer()
        }
            .modifier(TextFieldModifier())
    }
}

