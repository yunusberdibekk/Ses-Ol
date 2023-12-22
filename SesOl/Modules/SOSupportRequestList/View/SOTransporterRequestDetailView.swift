//
//  SOTransporterRequestDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct SOTransporterRequestDetailView: View {
    @EnvironmentObject var viewModel: SOSupportRequestListViewModel
    @Environment(\.dismiss) private var dismiss

    let transporterRequest: VoluntarilyTransporterResponseElement
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
                            await viewModel.deleteSupportRequest(path: .voluntarilyTransporter, index: index)
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
                            await viewModel.updateTransporterSupportRequest(status: .reject, request: transporterRequest, index: index)
                        }
                    } label: {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .foregroundColor(.red)
                    }

                    Button {
                        Task {
                            await viewModel.updateTransporterSupportRequest(status: .approve, request: transporterRequest, index: index)
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
            HStack(spacing: 3) {
                Text(transporterRequest.userName)
                Text(transporterRequest.userSurname)
            }
            .font(.subheadline)
            .bold()
            HStack(spacing: 0) {
                Text("@")
                Text(transporterRequest.userTel)
            }
            .font(.caption)
            .foregroundColor(.spanish_gray)
        }
    }

    @ViewBuilder private func bodyView() -> some View {
        Text(transporterRequest.voluntarilyDEC)
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
            Text("Talep edilen kurum: \(transporterRequest.unionName)")
            Text("Araç sayısı: \(transporterRequest.voluntarilyNumVehicle)")
            Text("Şoför sayısı: \(transporterRequest.voluntarilyNumDriver)")
            Text("Kalkış noktası: \(transporterRequest.voluntarilyFromLocation)")
            Text("Varış noktası: \(transporterRequest.voluntarilyFromLocation)")
            Text("Konum: \(transporterRequest.addressDistrict)/ \(transporterRequest.addressCity)/\(transporterRequest.addressCountry)")
            Text("Açık adres: \(transporterRequest.fullAddress)")
        }
        .padding(.top)
    }
}

#Preview {
    SOTransporterRequestDetailView(transporterRequest: VoluntarilyTransporterResponseElement.mockTransporterSupportRequestResponseElement, index: 0)
        .environmentObject(SOSupportRequestListViewModel())
}
