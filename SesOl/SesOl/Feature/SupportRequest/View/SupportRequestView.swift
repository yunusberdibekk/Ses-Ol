//
//  SupportRequestsView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 16.05.2023.
//
import SwiftUI

struct SupportRequestView: View {
    @StateObject private var supportRequestViewModel = SupportRequestViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("Seç", selection: $supportRequestViewModel.selectedSupportType) {
                        ForEach(SupportType.allCases, id: \.self) { supportType in
                            Text(supportType.description).tag(supportType)
                        }
                    }
                        .tint(.halloween_orange)
                        .pickerStyle(.menu)
                        .onChange(of: supportRequestViewModel.selectedSupportType) { newValue in
                        Task {
                            await supportRequestViewModel.refreshSupportRequests(newValue: newValue)
                        }
                    }
                    Spacer()
                    Text("Destek Talepleri")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                    .padding([.top, .trailing], PagePaddings.Normal.padding_20.rawValue)

                Picker("Seç", selection: $supportRequestViewModel.selectedOption) {
                    ForEach(RequestOptions.allCases, id: \.self) { option in
                        Text(option.description).tag(option)
                    }
                }
                    .pickerStyle(.segmented)
                    .foregroundColor(.red)
                    .cornerRadius(25)
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_10.rawValue)
                    .padding([.top, .bottom], 10)

                if supportRequestViewModel.isUnionAccount == 0 {
                    switch supportRequestViewModel.selectedSupportType {

                    case .providingAssistance:
                        switch supportRequestViewModel.selectedOption {
                        case .waiting:
                            ScrollView {
                                if let waitingRequests = supportRequestViewModel.waitingSupportRequests {
                                    CitizienProvidingAssistanceSubView(providingAssistance: waitingRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingSupportRequests()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedRequests = supportRequestViewModel.rejectedSupportRequests {
                                    CitizienProvidingAssistanceSubView(providingAssistance: rejectedRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedSupportRequests()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedRequests = supportRequestViewModel.approvedSupportRequests {
                                    CitizienProvidingAssistanceSubView(providingAssistance: approvedRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedSupportRequests()
                            }
                        }
                    case .psychologist:
                        switch supportRequestViewModel.selectedOption {
                        case .waiting:
                            ScrollView {
                                if let waitingVoluntarilyPsychologist = supportRequestViewModel.waitingVoluntarilyPsychologistRequests {
                                    CitizienVoluntarilyPsychologistSubView(voluntarilyPsychologist: waitingVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingVoluntarilyPsychologist()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyPsychologist = supportRequestViewModel.rejectedVoluntarilyPsychologistRequests {
                                    CitizienVoluntarilyPsychologistSubView(voluntarilyPsychologist: rejectedVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedVoluntarilyPsychologist()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyPsychologist = supportRequestViewModel.approvedVoluntarilyPsychologistRequests {
                                    CitizienVoluntarilyPsychologistSubView(voluntarilyPsychologist: approvedVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyPsychologist()
                            }
                        }
                    case .pitchTent:
                        switch supportRequestViewModel.selectedOption {
                        case .waiting:
                            ScrollView {
                                if let waitingVoluntarilyPitchTent = supportRequestViewModel.waitingVoluntarilyPitchTentRequests {
                                    CitizienVoluntarilyPitchTentSubView(voluntarilyPitchTent: waitingVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingVoluntarilyPitchTent()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyPitchTent = supportRequestViewModel.rejectedVoluntarilyPitchTentRequests {
                                    CitizienVoluntarilyPitchTentSubView(voluntarilyPitchTent: rejectedVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedSupportRequests()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyPitchTent = supportRequestViewModel.approvedVoluntarilyPitchTentRequests {
                                    CitizienVoluntarilyPitchTentSubView(voluntarilyPitchTent: approvedVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyPitchTent()
                            }
                        }
                    case .transporter:
                        switch supportRequestViewModel.selectedOption {
                        case .waiting:
                            ScrollView {
                                if let waitingVoluntarilyTransporter = supportRequestViewModel.waitingVoluntarilyTransporterRequests {
                                    CitizienVoluntarilyTransporterSubView(voluntarilyTransporter: waitingVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingSupportRequests()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyTransporter = supportRequestViewModel.rejectedVoluntarilyTransporterRequests {
                                    CitizienVoluntarilyTransporterSubView(voluntarilyTransporter: rejectedVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedVoluntarilyTransporter()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyTransporter = supportRequestViewModel.approvedVoluntarilyTransporterRequests {
                                    CitizienVoluntarilyTransporterSubView(voluntarilyTransporter: approvedVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyTransporter()
                            }
                        }
                    }
                } else {
                    switch supportRequestViewModel.selectedSupportType {
                    case .providingAssistance:
                        switch supportRequestViewModel.selectedOption {
                        case .waiting:
                            ScrollView {
                                if let waitingRequests = supportRequestViewModel.waitingSupportRequests {
                                    UnionProvidingAssistanceSubView(providingAssistance: waitingRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingSupportRequests()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedRequests = supportRequestViewModel.rejectedSupportRequests {
                                    UnionProvidingAssistanceSubView(providingAssistance: rejectedRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedSupportRequests()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedRequests = supportRequestViewModel.approvedSupportRequests {
                                    UnionProvidingAssistanceSubView(providingAssistance: approvedRequests)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedSupportRequests()
                            }
                        }
                    case .psychologist:
                        switch supportRequestViewModel.selectedOption {
                        case.waiting:
                            ScrollView {
                                if let waitingVoluntarilyPsychologist = supportRequestViewModel.waitingVoluntarilyPsychologistRequests {
                                    UnionVoluntarilyPsychologistSubView(voluntarilyPsychologist: waitingVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingSupportRequests()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyPsychologist = supportRequestViewModel.rejectedVoluntarilyPsychologistRequests {
                                    UnionVoluntarilyPsychologistSubView(voluntarilyPsychologist: rejectedVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedVoluntarilyPsychologist()
                            }

                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyPsychologist = supportRequestViewModel.approvedVoluntarilyPsychologistRequests {
                                    UnionVoluntarilyPsychologistSubView(voluntarilyPsychologist: approvedVoluntarilyPsychologist)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyPsychologist()
                            }
                        }
                    case .pitchTent:
                        switch supportRequestViewModel.selectedOption {
                        case.waiting:
                            ScrollView {
                                if let waitingVoluntarilyPitchTent = supportRequestViewModel.waitingVoluntarilyPitchTentRequests {
                                    UnionVoluntarilyPitchTentSubView(voluntarilyPitchTent: waitingVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getWaitingVoluntarilyPitchTent()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyPitchTent = supportRequestViewModel.rejectedVoluntarilyPitchTentRequests {
                                    UnionVoluntarilyPitchTentSubView(voluntarilyPitchTent: rejectedVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getRejectedVoluntarilyPitchTent()

                            }
                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyPitchTent = supportRequestViewModel.approvedVoluntarilyPitchTentRequests {
                                    UnionVoluntarilyPitchTentSubView(voluntarilyPitchTent: approvedVoluntarilyPitchTent)
                                } else {
                                    SystemMessageRow()
                                }
                            }.refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyPitchTent()

                            }
                        }
                    case .transporter:
                        switch supportRequestViewModel.selectedOption {
                        case.waiting:
                            ScrollView {
                                if let waitingVoluntarilyTransporter = supportRequestViewModel.waitingVoluntarilyTransporterRequests {
                                    UnionVoluntarilyTransporterSubView(voluntarilyTransporter: waitingVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }
                                .refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyTransporter()
                            }
                        case .rejected:
                            ScrollView {
                                if let rejectedVoluntarilyTransporter = supportRequestViewModel.rejectedVoluntarilyTransporterRequests {
                                    UnionVoluntarilyTransporterSubView(voluntarilyTransporter: rejectedVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }
                                .refreshable {
                                await supportRequestViewModel.getRejectedVoluntarilyTransporter()
                            }
                        case .approved:
                            ScrollView {
                                if let approvedVoluntarilyTransporter = supportRequestViewModel.approvedVoluntarilyTransporterRequests {
                                    UnionVoluntarilyTransporterSubView(voluntarilyTransporter: approvedVoluntarilyTransporter)
                                } else {
                                    SystemMessageRow()
                                }
                            }
                                .refreshable {
                                await supportRequestViewModel.getApprovedVoluntarilyTransporter()
                            }
                        }
                    }
                }
                Spacer()
            }
                .onAppear {
                supportRequestViewModel.readCache(userIdKey: .userId, isUnionKey: .isUnionAccount)
                Task {
                    switch supportRequestViewModel.selectedSupportType {
                    case .providingAssistance:
                        await supportRequestViewModel.getWaitingSupportRequests()
                        await supportRequestViewModel.getRejectedSupportRequests()
                        await supportRequestViewModel.getApprovedSupportRequests()
                    case .psychologist:
                        await supportRequestViewModel.getWaitingVoluntarilyPsychologist()
                        await supportRequestViewModel.getRejectedVoluntarilyPsychologist()
                        await supportRequestViewModel.getApprovedVoluntarilyPsychologist()
                    case .pitchTent:
                        await supportRequestViewModel.getWaitingVoluntarilyPitchTent()
                        await supportRequestViewModel.getRejectedVoluntarilyPitchTent()
                        await supportRequestViewModel.getApprovedVoluntarilyPitchTent()
                    case .transporter:
                        await supportRequestViewModel.getWaitingVoluntarilyTransporter()
                        await supportRequestViewModel.getRejectedVoluntarilyTransporter()
                        await supportRequestViewModel.getApprovedVoluntarilyTransporter()
                    }

                }
            }
        }
    }
}

struct SupportRequestView_Previews: PreviewProvider {
    static var previews: some View {
        SupportRequestView()
    }
}

private struct CitizienProvidingAssistanceSubView: View {
    var providingAssistance: ProvidingAssistanceResponse

    var body: some View {
        VStack {
            ForEach(providingAssistance, id: \.assistanceID) { request in
                NavigationLink {
                    CitizienProvidingAssistanceDetail(providingAssistance: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    SupportRequestRow(supportRequest: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }

        }
    }
}

private struct UnionProvidingAssistanceSubView: View {
    var providingAssistance: ProvidingAssistanceResponse

    var body: some View {
        VStack {
            ForEach(providingAssistance, id: \.assistanceID) { request in
                NavigationLink {
                    UnionProvidingAssistanceDetail(providingAssistance: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    SupportRequestRow(supportRequest: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}

private struct CitizienVoluntarilyPsychologistSubView: View {
    var voluntarilyPsychologist: VoluntarilyPsychologistResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyPsychologist, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    CitizienVoluntarilyPsychologist(voluntarilyPsychologist: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyPsychologistRow(voluntarilyPsychologist: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}

private struct CitizienVoluntarilyPitchTentSubView: View {
    var voluntarilyPitchTent: VoluntarilyPitchTentResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyPitchTent, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    CitizienVoluntarilyPitchTent(voluntarilyPitchTent: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyPitchTentRow(voluntarilyPitchTent: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}

private struct CitizienVoluntarilyTransporterSubView: View {
    var voluntarilyTransporter: VoluntarilyTransporterResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyTransporter, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    CitizienVoluntarilyTransporter(voluntarilTransporter: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyTransporterRow(voluntarilTransporter: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}

private struct UnionVoluntarilyPsychologistSubView: View {
    var voluntarilyPsychologist: VoluntarilyPsychologistResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyPsychologist, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    UnionVoluntarilyPsychologist(voluntarilyPsychologist: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyPsychologistRow(voluntarilyPsychologist: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}

private struct UnionVoluntarilyPitchTentSubView: View {
    var voluntarilyPitchTent: VoluntarilyPitchTentResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyPitchTent, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    UnionVoluntarilyPitchTent(voluntarilyPitchTent: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyPitchTentRow(voluntarilyPitchTent: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }

        }
    }
}

private struct UnionVoluntarilyTransporterSubView: View {
    var voluntarilyTransporter: VoluntarilyTransporterResponse

    var body: some View {
        VStack {
            ForEach(voluntarilyTransporter, id: \.voluntarilyAccountID) { request in
                NavigationLink {
                    UnionVoluntarilyTransporter(voluntarilTransporter: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    VoluntarilyTransporterRow(voluntarilTransporter: request)
                        .padding(.top, 3)
                        .foregroundColor(.dark_liver)
                }
            }
        }
    }
}
