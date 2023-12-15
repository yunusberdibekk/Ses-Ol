//
//  IbanDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 11.06.2023.
//

import SwiftUI

struct IbanDetailView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userID") var userID = 0

    var body: some View {
        VStack {
            headerView
            ibansView()
            ibanOptionsView()
            Spacer()
        }
        .padding(.top, PagePaddings.Normal.padding_20.rawValue)
        .padding(.all, PagePaddings.Normal.padding_10.rawValue)
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
                await viewModel.readUnionIbans(with: userID)
            }
        }
    }

    private var headerView: some View {
        HStack {
            Spacer()
            Text("Kurum İbanları")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
        }
        .padding([.top, .trailing], PagePaddings.Normal.padding_20.rawValue)
    }

    @ViewBuilder private func ibansView() -> some View {
        Picker("Seç", selection: $viewModel.ibanOption) {
            ForEach(IbanOptions.allCases, id: \.self) { option in
                Text(option.description)
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
        .padding(.all, PagePaddings.Normal.padding_10.rawValue)
    }

    @ViewBuilder private func ibanOptionsView() -> some View {
        VStack(spacing: 15) {
            switch viewModel.ibanOption {
            case .create:
                ibanCell(icon: "paragraphsign",
                         title: "İban Başlık",
                         text: $viewModel.ibanTitle)
                ibanCell(icon: "number",
                         title: "İban No",
                         text: $viewModel.ibanTitle)
                customIbanButton(title: "Oluştur") {
                    Task {
                        await viewModel.createUnionIban(with: userID)
                    }
                }
                .padding(.top, PagePaddings.Normal.padding_10.rawValue)
            case .update:
                ibanList()
                ibanCell(icon: "paragraphsign",
                         title: "İban Başlık",
                         text: $viewModel.ibanTitle)
                ibanCell(icon: "number",
                         title: "İban No",
                         text: $viewModel.ibanNo)
                customIbanButton(title: "Güncelle") {
                    Task {
                        await viewModel.updateUnionIban(with: userID)
                    }
                }
                .padding(.top, PagePaddings.Normal.padding_10.rawValue)
            case .delete:
                ibanList()
                customIbanButton(title: "Sil") {
                    Task {
                        await viewModel.deleteUnionIban(with: userID)
                    }
                }
            }
        }
        .padding(.all, PagePaddings.Normal.padding_20.rawValue)
        .onAppear {
            Task {
                await viewModel.readUnionIbans(with: userID)
            }
        }
    }

    @ViewBuilder private func ibanList() -> some View {
        HStack {
            Image(systemName: "creditcard.fill")
                .foregroundColor(.halloween_orange)
            Picker("Kurum İbanlar", selection: $viewModel.selectedIbanID) {
                Text("Seç").tag(0)
                ForEach(viewModel.unionIbans, id: \.ibanID) { iban in
                    Text("\(iban.ibanTitle ?? ""), \(iban.iban ?? "")").tag(iban.ibanID ?? 0)
                        .foregroundColor(.spanish_gray)
                }
            }
            .foregroundColor(.gray.opacity(0.6))
            .pickerStyle(.navigationLink)
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func ibanCell(icon: String, title: String, text: Binding<String>) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.halloween_orange)
            TextField(title, text: text)
                .foregroundColor(.spanish_gray)
            Spacer()
        }
        .modifier(TextFieldModifier())
    }

    @ViewBuilder private func customIbanButton(title: String, action: @escaping () -> Void) -> some View {
        HStack {
            Spacer()
            Button {
                action()
            } label: {
                Text(title)
                    .foregroundColor(.halloween_orange)
            }
            Spacer()
        }
    }
}

#Preview {
    IbanDetailView()
        .environmentObject(ProfileViewModel())
}
