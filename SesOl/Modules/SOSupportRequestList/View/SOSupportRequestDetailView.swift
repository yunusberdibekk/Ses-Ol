//
//  SOCitizienSupportRequestDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

struct SOSupportRequestDetailView: View {
    @EnvironmentObject var viewModel: SOSupportRequestListViewModel
    @Environment(\.dismiss) private var dismiss

    let supportRequest: ProvidingAssistanceResponseElement
    let index: Int

    var body: some View {
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
            switch viewModel.userType {
            case .citizien:
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.deleteSupportRequest(path: .providingAssistanceCrud, index: index)
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.halloween_orange)
                    }
                }
            case .union:
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await viewModel.updateStandartSupportRequest(status: .reject, request: supportRequest, index: index)
                        }
                    } label: {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .foregroundColor(.red)
                    }

                    Button {
                        Task {
                            await viewModel.updateStandartSupportRequest(status: .approve, request: supportRequest, index: index)
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title3)
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding(.all, 20)
        .modifier(RequestCellModifier())
        .alert("Dikkat!", isPresented: $viewModel.logStatus) {
            Text(viewModel.logMessage)
            Button("Tamam", role: .cancel) {}
        }
    }

    @ViewBuilder private func headerView() -> some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.halloween_orange)
                .font(.largeTitle)
            Text(supportRequest.fullname)
                .font(.subheadline)
                .bold()
            HStack(spacing: 0) {
                Text("@")
                Text(supportRequest.userTel)
            }
            .font(.caption)
            .foregroundColor(.spanish_gray)
        }
    }

    @ViewBuilder private func bodyView() -> some View {
        Text(supportRequest.assistanceTitle)
            .foregroundColor(.halloween_orange)
            .font(.title3)
            .bold()
            .padding(.bottom, 4)
        Text(supportRequest.assistanceDescription)
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
            Text("Talep edilen kurum: \(supportRequest.assistanceSentUnionName)")
            Text("Talep kategori: \(supportRequest.assistanceCategoryName)")
            Text("Destek kişi sayısı: \(supportRequest.assistanceNumOfPerson.description)")
            Text("Konum: \(supportRequest.addressDistrict)/ \(supportRequest.addressCity)/\(supportRequest.addressCountry)")
            Text("Açık adres: \(supportRequest.fullAddress)")
        }
        .padding(.top)
    }
}

#Preview {
    SOSupportRequestDetailView(supportRequest: ProvidingAssistanceResponseElement.mockStandartSupportRequestResponseElement1, index: 0)
        .environmentObject(SOSupportRequestListViewModel())
}
