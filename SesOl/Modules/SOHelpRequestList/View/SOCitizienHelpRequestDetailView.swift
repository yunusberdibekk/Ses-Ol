//
//  SOCitizienHelpRequestDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import SwiftUI

struct SOCitizienHelpRequestDetailView: View {
    @EnvironmentObject var viewModel: SOHelpRequestListViewModel
    @Environment(\.dismiss) private var dismiss
    let helpRequest: HelpRequestResponseElement
    let index: Int

    @ViewBuilder private func headerView() -> some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.halloween_orange)
                .font(.largeTitle)
            HStack(spacing: 3) {
                Text(helpRequest.userName)
                Text(helpRequest.userSurname)
            }
            .font(.subheadline)
            .bold()
            HStack(spacing: 0) {
                Text("@")
                Text(helpRequest.userTel)
            }
            .font(.caption)
            .foregroundColor(.spanish_gray)
        }
    }

    @ViewBuilder private func bodyView() -> some View {
        Text(helpRequest.requestDesc)
            .multilineTextAlignment(.leading)
        Divider()
            .padding(.bottom)
    }

    @ViewBuilder private func footerView() -> some View {
        Text("Talep Detayları")
            .foregroundColor(.halloween_orange)
            .font(.title3)
            .bold()
        VStack(alignment: .leading, spacing: 4) {
            Text("Talep edilen kurum: \(helpRequest.requestUnionName)")
            Text("Afet kategori: \(helpRequest.requestDisasterName)")
            Text("İrtibat no: \(helpRequest.userTel)")
            Text("Konum: \(helpRequest.requestDistrict)/ \(helpRequest.requestCity)/\(helpRequest.requestCountry)")
            Text("Açık adres: \(helpRequest.requestFullAddress)")
        }
        .padding(.top)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                headerView()
                bodyView()
                    .padding(.top)
                footerView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.halloween_orange)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.deleteHelpRequest(
                                requestID: helpRequest.requestID, index: index)
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.halloween_orange)
                    }
                }
            }
            .alert("Dikkat!", isPresented: $viewModel.logStatus, actions: {
                Text(viewModel.logMessage)
            })
            .padding(.all, 20)
            .modifier(RequestCellModifier())
        }
    }
}

#Preview {
    SOCitizienHelpRequestDetailView(
        helpRequest: HelpRequestResponseElement.dummyHelpRequestResponseElement,
        index: 0)
        .environmentObject(SOHelpRequestListViewModel())
}
