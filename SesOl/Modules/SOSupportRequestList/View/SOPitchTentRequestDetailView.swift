//
//  SOPitchTentRequestDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct SOPitchTentRequestDetailView: View {
    @EnvironmentObject var viewModel: SOSupportRequestListViewModel
    @Environment(\.dismiss) private var dismiss

    let pitchTentRequest: VoluntarilyPitchTentResponseElement
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
                            await viewModel.deleteSupportRequest(path: .voluntarilyPitchTent, index: index)
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
                            await viewModel.updatePitchTentSupportRequest(status: .reject, request: pitchTentRequest, index: index)
                        }
                    } label: {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .foregroundColor(.red)
                    }

                    Button {
                        Task {
                            await viewModel.updatePitchTentSupportRequest(status: .approve, request: pitchTentRequest, index: index)
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
                Text(pitchTentRequest.userName)
                Text(pitchTentRequest.userSurname)
            }
            .font(.subheadline)
            .bold()
            HStack(spacing: 0) {
                Text("@")
                Text(pitchTentRequest.userTel)
            }
            .font(.caption)
            .foregroundColor(.spanish_gray)
        }
    }

    @ViewBuilder private func bodyView() -> some View {
        Text(pitchTentRequest.voluntarilyDesc)
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
            Text("Talep edilen kurum: \(pitchTentRequest.unionName)")
            Text("Araç durumu: \((pitchTentRequest.voluntarilyVehicleStatus == 1) ? "Var" : "Yok")")
            Text("Konum: \(pitchTentRequest.addressDistrict)/ \(pitchTentRequest.addressCity)/\(pitchTentRequest.addressCountry)")
            Text("Açık adres: \(pitchTentRequest.fullAddress)")
        }
        .padding(.top)
    }
}

#Preview {
    SOPitchTentRequestDetailView(pitchTentRequest: VoluntarilyPitchTentResponseElement.mockPitchTentSupportRequestResponseElement, index: 0)
        .environmentObject(SOSupportRequestListViewModel())
}
