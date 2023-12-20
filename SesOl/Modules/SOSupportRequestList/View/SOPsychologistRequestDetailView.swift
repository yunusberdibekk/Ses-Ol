//
//  SOPsychologistRequestDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct SOPsychologistRequestDetailView: View {
    @EnvironmentObject var viewModel: SOSupportRequestListViewModel
    @Environment(\.dismiss) private var dismiss

    let psychologistRequest: VoluntarilyPsychologistResponseElement
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
                            await viewModel.deleteSupportRequest(path: .voluntarilyPsychologist, index: index)
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
                            await viewModel.updatePsychologistSupportRequest(status: .reject, request: psychologistRequest, index: index)
                        }
                    } label: {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .foregroundColor(.red)
                    }

                    Button {
                        Task {
                            await viewModel.updatePsychologistSupportRequest(status: .approve, request: psychologistRequest, index: index)
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
                Text(psychologistRequest.userName)
                Text(psychologistRequest.userSurname)
            }
            .font(.subheadline)
            .bold()
            HStack(spacing: 0) {
                Text("@")
                Text(psychologistRequest.userTel)
            }
            .font(.caption)
            .foregroundColor(.spanish_gray)
        }
    }

    @ViewBuilder private func bodyView() -> some View {
        Text(psychologistRequest.voluntarilyDesc)
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
            Text("Talep edilen kurum: \(psychologistRequest.unionName)")
            Text("Araç durumu: \((psychologistRequest.voluntarilyVehicleStatus == 1) ? "Var" : "Yok")")
            Text("Konum: \(psychologistRequest.addressDistrict)/ \(psychologistRequest.addressCity)/\(psychologistRequest.addressCountry)")
            Text("Açık adres: \(psychologistRequest.fullAddress)")
        }
        .padding(.top)
    }
}

#Preview {
    SOPsychologistRequestDetailView(psychologistRequest: VoluntarilyPsychologistResponseElement.dummyModel, index: 0)
        .environmentObject(SOSupportRequestListViewModel())
}
