//
//  IbanDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 11.06.2023.
//

import SwiftUI

struct IbanDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Kurum İbanları")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                    .padding([.top, .trailing], PagePaddings.Normal.padding_20.rawValue)

                Picker("Seç", selection: $viewModel.selectedIbanOption) {
                    ForEach(IbanOptions.allCases, id: \.self) { option in
                        Text(option.description).tag(option)
                    }
                }
                    .pickerStyle(.segmented)
                    .padding(.all, PagePaddings.Normal.padding_10.rawValue)
                    .onChange(of: viewModel.selectedIbanOption) { _newValue in
                    Task {
                        await viewModel.readIbans()
                    }
                }
                switch viewModel.selectedIbanOption {
                case .create:
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "paragraphsign")
                                .foregroundColor(.halloween_orange)
                            TextField("Başlık", text: $viewModel.ibanCreateTittle)
                                .foregroundColor(.spanish_gray)
                            Spacer()
                        }.modifier(TextFieldModifier())

                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(.halloween_orange)
                            TextField("İban no", text: $viewModel.ibanCreateNo)
                                .foregroundColor(.spanish_gray)
                            Spacer()
                        }
                            .modifier(TextFieldModifier())

                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    await viewModel.createIban()
                                    await viewModel.readIbans()
                                }
                            } label: {
                                Text("Oluştur")
                                    .foregroundColor(.halloween_orange)
                            }
                            Spacer()
                        }
                            .padding(.top, PagePaddings.Normal.padding_10.rawValue)
                    }
                        .padding(.all, PagePaddings.Normal.padding_20.rawValue)
                case .update:
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(.halloween_orange)

                            Picker("Kurum İbanlar", selection: $viewModel.ibanUpdateId) {
                                Text("Seç").tag(0)
                                ForEach(viewModel.ibans, id: \.ibanID) { iban in
                                    Text("\(iban.ibanTitle ?? ""), \(iban.iban ?? "")").tag(iban.ibanID ?? 0)
                                        .foregroundColor(.spanish_gray)
                                }
                            }
                                .foregroundColor(.gray.opacity(0.6))
                                .pickerStyle(.navigationLink)
                        }
                            .modifier(TextFieldModifier())

                        HStack {
                            Image(systemName: "paragraphsign")
                                .foregroundColor(.halloween_orange)
                            TextField("Başlık", text: $viewModel.ibanUpdateTittle)
                                .foregroundColor(.spanish_gray)
                            Spacer()
                        }
                            .modifier(TextFieldModifier())

                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(.halloween_orange)
                            TextField("İban no", text: $viewModel.ibanUpdateNo)
                                .foregroundColor(.spanish_gray)
                            Spacer()
                        }
                            .modifier(TextFieldModifier())

                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    await viewModel.updateIban()
                                    await viewModel.readIbans()
                                }
                            } label: {
                                Text("Oluştur")
                                    .foregroundColor(.halloween_orange)
                            }
                            Spacer()
                        }
                            .padding(.top, PagePaddings.Normal.padding_10.rawValue)
                    }
                        .padding(.all, PagePaddings.Normal.padding_20.rawValue)
                case .delete:
                    VStack(spacing: 30) {
                        HStack {
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(.halloween_orange)

                            Picker("Kurum İbanlar", selection: $viewModel.ibanDeletedId) {
                                Text("Seç").tag(0)
                                ForEach(viewModel.ibans, id: \.ibanID) { iban in
                                    Text("\(iban.ibanTitle ?? ""), \(iban.iban ?? "")").tag(iban.ibanID ?? 0)
                                        .foregroundColor(.spanish_gray)
                                }
                            }
                                .foregroundColor(.gray.opacity(0.6))
                                .pickerStyle(.navigationLink)
                        }
                            .modifier(TextFieldModifier())

                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    await viewModel.deleteIban()
                                    await viewModel.readIbans()
                                }
                            } label: {
                                Text("Sil")
                                    .foregroundColor(.halloween_orange)
                            }
                            Spacer()
                        }
                    }
                        .padding(.all, PagePaddings.Normal.padding_20.rawValue)

                }
                Spacer()
            }
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
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.all, PagePaddings.Normal.padding_10.rawValue)
                .alert("Tebrikler", isPresented: $viewModel.ibanCreated, actions: {

            }, message: {
                    Text("Iban oluşturma işleminiz başarıyla sonuçlanmıştır.")
                })
                .alert("Tebrikler", isPresented: $viewModel.ibanDeleted, actions: {

            }, message: {
                    Text("Iban silme işleminiz başarıyla sonuçlanmıştır.")
                })
                .alert("Tebrikler", isPresented: $viewModel.ibanUpdated, actions: {

            }, message: {
                    Text("Iban güncelleme işleminiz başarıyla sonuçlanmıştır.")
                })
                .onAppear {
                Task {
                    await viewModel.readIbans()
                }
            }
        }
    }
}

struct IbanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IbanDetailView()
    }
}
