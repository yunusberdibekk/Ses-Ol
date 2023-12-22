//
//  SOSupportRequestListView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

struct SOSupportRequestListView: View {
    @AppStorage("userID") var userID: Int = 0
    @AppStorage("userType") var userType: UserType = .citizien
    @StateObject var viewModel: SOSupportRequestListViewModel = .init()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Seç", selection: $viewModel.selectedSupportRequestType) {
                        ForEach(SupportRequestTypes.allCases, id: \.self) {
                            Text($0.title)
                                .tag($0)
                        }
                    }
                } header: {
                    Text("Destek Talep Türleri")
                }

                Section {
                    Picker("Seç", selection: $viewModel.selectedRequestStatus) {
                        ForEach(RequestStatus.allCases, id: \.self) {
                            Text($0.description)
                                .tag($0)
                        }
                    }
                } header: {
                    Text("Talep Durumu")
                }

                Section {
                    switch viewModel.selectedSupportRequestType {
                    case .standart:
                        standartSupportRequest
                    case .psyhlogist:
                        psyhlogistSupportRequest
                    case .pitchtent:
                        pitchTentSupportRequest
                    case .transporter:
                        transporterRequest
                    }
                } header: {
                    Text(viewModel.selectedSupportRequestType.title)
                }
            }
            .listStyle(.plain)
            .onChange(of: viewModel.selectedRequestStatus, perform: { value in
                Task {
                    await viewModel.fetchAdditionalSupportRequests(status: value)
                }
            })
            .refreshable {
                Task {
                    await viewModel.fetchAdditionalSupportRequests(status: viewModel.selectedRequestStatus)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchAdditionalSupportRequests(status: viewModel.selectedRequestStatus)
                }
            }
        }
    }

    private var standartSupportRequest: some View {
        switch viewModel.selectedRequestStatus {
        case .waiting:
            supportRequestList(requests: viewModel.waitingStandartSupportRequests)
        case .rejected:
            supportRequestList(requests: viewModel.rejectedStandartSupportRequests)
        case .approved:
            supportRequestList(requests: viewModel.approvedStandartSupportRequests)
        }
    }

    private var psyhlogistSupportRequest: some View {
        switch viewModel.selectedRequestStatus {
        case .waiting:
            psyhlogistSupportRequestList(requests: viewModel.waitingPsyhlogistSupportRequests)
        case .rejected:
            psyhlogistSupportRequestList(requests: viewModel.rejectedPsyhlogistSupportRequests)
        case .approved:
            psyhlogistSupportRequestList(requests: viewModel.approvedPsyhlogistSupportRequests)
        }
    }

    private var pitchTentSupportRequest: some View {
        switch viewModel.selectedRequestStatus {
        case .waiting:
            pitchTentSupportRequestList(requests: viewModel.waitingPitchTentSupportRequests)
        case .rejected:
            pitchTentSupportRequestList(requests: viewModel.rejectedPitchTentSupportRequests)
        case .approved:
            pitchTentSupportRequestList(requests: viewModel.approvedPitchTentSupportRequests)
        }
    }

    private var transporterRequest: some View {
        switch viewModel.selectedRequestStatus {
        case .waiting:
            transporterSupportRequestList(requests: viewModel.waitingTransporterSupportRequests)
        case .rejected:
            transporterSupportRequestList(requests: viewModel.rejectedTransporterSupportRequests)
        case .approved:
            transporterSupportRequestList(requests: viewModel.approvedTransporterSupportRequests)
        }
    }

    /// Standart Destek Talebi
    @ViewBuilder private func supportRequestList(requests: ProvidingAssistanceResponse) -> some View {
        ForEach(0 ..< requests.count, id: \.self) { index in
            NavigationLink {
                SOSupportRequestDetailView(supportRequest: requests[index], index: index)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(viewModel)
            } label: {
                supportRequestCell(request: requests[index])
            }
        }
    }

    @ViewBuilder private func supportRequestCell(request: ProvidingAssistanceResponseElement) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView(
                name: request.fullname,
                surname: "",
                tel: request.userTel)
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
            bodyView(desc: request.assistanceDescription)
        }
        .modifier(RequestCellModifier())
    }

    /// Psikolojik destek talebi
    @ViewBuilder private func psyhlogistSupportRequestList(requests: VoluntarilyPsychologistResponse) -> some View {
        ForEach(0 ..< requests.count, id: \.self) { index in
            NavigationLink {
                SOPsychologistRequestDetailView(psychologistRequest: requests[index], index: index)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(viewModel)
            } label: {
                psychologistRequestCell(request: requests[index])
            }
        }
    }

    @ViewBuilder private func psychologistRequestCell(request: VoluntarilyPsychologistResponseElement) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView(
                name: request.userName,
                surname: request.userSurname,
                tel: request.userTel)
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
            bodyView(desc: request.voluntarilyDesc)
        }
        .modifier(RequestCellModifier())
    }

    /// Çadır kurma destek talebi
    @ViewBuilder private func pitchTentSupportRequestList(requests: VoluntarilyPitchTentResponse) -> some View {
        ForEach(0 ..< requests.count, id: \.self) { index in
            NavigationLink {
                SOPitchTentRequestDetailView(pitchTentRequest: requests[index], index: index)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(viewModel)
            } label: {
                pitchTentRequestCell(request: requests[index])
            }
        }
    }

    @ViewBuilder private func pitchTentRequestCell(request: VoluntarilyPitchTentResponseElement) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView(
                name: request.userName,
                surname: request.userSurname,
                tel: request.userTel)
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
            bodyView(desc: request.voluntarilyDesc)
        }
        .modifier(RequestCellModifier())
    }

    /// Taşımacılık destek talebi
    @ViewBuilder private func transporterSupportRequestList(requests: VoluntarilyTransporterResponse) -> some View {
        ForEach(0 ..< requests.count, id: \.self) { index in
            NavigationLink {
                SOTransporterRequestDetailView(transporterRequest: requests[index], index: index)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(viewModel)
            } label: {
                transporterRequestCell(request: requests[index])
            }
        }
    }

    @ViewBuilder private func transporterRequestCell(request: VoluntarilyTransporterResponseElement) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView(
                name: request.userName,
                surname: request.userSurname,
                tel: request.userTel)
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
            bodyView(desc: request.voluntarilyDEC)
        }
        .modifier(RequestCellModifier())
    }

    @ViewBuilder private func headerView(name: String, surname: String, tel: String) -> some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.halloween_orange)

            HStack(spacing: 5) {
                HStack(spacing: 3) {
                    Text(name)
                    Text(surname)
                }
                .font(.subheadline).bold()

                HStack(spacing: 0) {
                    Text("@")
                    Text(tel)
                }
                .font(.caption)
                .foregroundColor(.spanish_gray)
            }
        }
    }

    @ViewBuilder private func bodyView(desc: String) -> some View {
        VStack(spacing: 0) {
            Text(desc)
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            Divider()
        }
    }
}

#Preview {
    SOSupportRequestListView()
}
