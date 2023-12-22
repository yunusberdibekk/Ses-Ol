//
//  SOProfileIbanView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.12.2023.
//

import SwiftUI

enum IbanViewOptions: CaseIterable {
    case ibans
    case create
    case update
}

struct SOProfileIbanView: View {
    @EnvironmentObject var viewModel: SOProfileViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(0 ..< viewModel.unionIbans.count, id: \.self) { index in
                    let iban = viewModel.unionIbans[index]
                    DisclosureGroup(iban.ibanTitle) {
                        NavigationLink {
                            ibanDetailView(iban: iban)
                        } label: {
                            Text(iban.iban)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Sil", role: .destructive) {
                            Task {
                                print(index.description)
                                await viewModel.deleteUnionIban(ibanID: iban.id, index: index)
                            }
                        }
                    }
                }
            }
            .navigationTitle("İbanlarım")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ibanCreateView()
                    } label: {
                        Image(systemName: "creditcard")
                            .font(.title3)
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    await viewModel.readUnionIbans()
                }
            })
        }
    }

    @ViewBuilder private func ibanDetailView(iban: IbanReadResponseElement) -> some View {
        Form {
            Section {
                TextField(iban.ibanTitle, text: $viewModel.ibanTitle)
            } header: {
                Text("IBAN TİTLE")
            }

            Section {
                TextField(iban.iban, text: $viewModel.ibanNo)
            } header: {
                Text("IBAN NO")
            }

            Button("Güncelle") {
                Task {
                    await viewModel.updateUnionIban(ibanID: iban.id)
                }
            }
            .modifier(DefaultListButtonModifier(backgroundColor: .blue))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(iban.ibanTitle)
    }

    @ViewBuilder private func ibanCreateView() -> some View {
        Form {
            Section {
                TextField("", text: $viewModel.ibanTitle)
            } header: {
                Text("IBAN TİTLE")
            }

            Section {
                TextField("", text: $viewModel.ibanNo)
            } header: {
                Text("IBAN NO")
            }

            Button("Oluştur") {
                Task {
                    await viewModel.createUnionIban()
                }
            }
            .modifier(DefaultListButtonModifier(backgroundColor: .blue))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("İban Oluştur")
    }
}

#Preview {
    NavigationStack {
        SOProfileIbanView()
            .environmentObject(SOProfileViewModel())
    }
}
