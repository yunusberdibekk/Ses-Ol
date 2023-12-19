//
//  SOHelpRequestListView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 7.05.2023.
//

import SwiftUI

struct SOHelpRequestListView: View {
    @StateObject var viewModel: SOHelpRequestListViewModel = .init()

    var body: some View {
        NavigationStack {
            ScrollView {
                Picker("Seç", selection: $viewModel.selectedRequestStatus) {
                    ForEach(RequestStatus.allCases, id: \.self) { option in
                        Text(option.description)
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .foregroundStyle(.red)

                switch viewModel.selectedRequestStatus {
                case .waiting:
                    helpRequestList(requestList: viewModel.waitingHelpRequests)
                case .rejected:
                    helpRequestList(requestList: viewModel.rejectedHelpRequests)
                case .approved:
                    helpRequestList(requestList: viewModel.approvedHelpRequests)
                }
            }
            .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
            .padding([.top, .bottom], PagePaddings.Normal.padding_10.rawValue)
            .navigationTitle("Yardım Talepleri")
            .navigationBarTitleDisplayMode(.automatic)
            .refreshable(action: {
                switch viewModel.selectedRequestStatus {
                case .waiting:
                    await viewModel.getWaitingHelpRequests()
                case .rejected:
                    await viewModel.getRejectedHelpRequests()
                case .approved:
                    await viewModel.getApprovedHelpRequests()
                }
            })
            .onAppear {
                Task {
                    await viewModel.getWaitingHelpRequests()
                    await viewModel.getApprovedHelpRequests()
                    await viewModel.getRejectedHelpRequests()
                }
            }
        }
    }

    @ViewBuilder private func helpRequestList(requestList: HelpRequestResponse) -> some View {
        switch viewModel.userType {
        case .citizien:
            ForEach(requestList, id: \.requestID) { request in
                NavigationLink {
                    SOCitizienHelpRequestDetailView(helpRequest: request, index: 0)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    SOHelpRequestCell(helpRequest: request)
                }
            }
        case .union:
            ForEach(0 ..< requestList.count, id: \.self) { index in
                NavigationLink {
                    SOUnionHelpRequestDetailView(
                        helpRequest: requestList[index],
                        index: index)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    SOHelpRequestCell(helpRequest: requestList[index])
                }
            }
        }
    }
}

#Preview {
    SOHelpRequestListView()
}
