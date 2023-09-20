//
//  RequestsView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 7.05.2023.
//

import SwiftUI

struct HelpRequestView: View {
    @StateObject private var helpRequestViewModel = HelpRequestViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Yardım Talepleri")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                    .padding([.trailing, .top], PagePaddings.Normal.padding_20.rawValue)

                Picker("Seç", selection: $helpRequestViewModel.selectedOption) {
                    ForEach(RequestOptions.allCases, id: \.self) { option in
                        Text(option.description).tag(option)
                    }
                }
                    .pickerStyle(.segmented)
                    .foregroundColor(.red)
                    .cornerRadius(25)
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                    .padding([.top, .bottom], PagePaddings.Normal.padding_10.rawValue)
                Spacer()

                if helpRequestViewModel.isUnionAccount == 0 {
                    switch helpRequestViewModel.selectedOption {
                    case .waiting:
                        ScrollView {
                            if let waitingHelpRequests = helpRequestViewModel.waitingHelpRequests {
                                CitizienHelpRequestSubView(helpRequest: waitingHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {

                        }
                    case .rejected:
                        ScrollView {
                            if let rejectedHelpRequests = helpRequestViewModel.rejectedHelpRequests {
                                CitizienHelpRequestSubView(helpRequest: rejectedHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {

                        }
                    case .approved:
                        ScrollView {
                            if let approvedHelpRequests = helpRequestViewModel.approvedHelpRequests {
                                CitizienHelpRequestSubView(helpRequest: approvedHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {

                        }
                    }

                } else {
                    //Union view
                    switch helpRequestViewModel.selectedOption {
                    case .waiting:
                        ScrollView {
                            if let waitingHelpRequests = helpRequestViewModel.waitingHelpRequests {
                                UnionHelpRequestSubView(helpRequest: waitingHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {
                            await helpRequestViewModel.getWaitingHelpRequests()
                        }
                    case .rejected:
                        ScrollView {
                            if let rejectedHelpRequests = helpRequestViewModel.rejectedHelpRequests {
                                UnionHelpRequestSubView(helpRequest: rejectedHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {
                            await helpRequestViewModel.getRejectedHelpRequests()
                        }
                    case .approved:
                        ScrollView {
                            if let approvedHelpRequests = helpRequestViewModel.approvedHelpRequests {
                                UnionHelpRequestSubView(helpRequest: approvedHelpRequests)
                            } else {
                                SystemMessageRow()
                            }
                        }.refreshable {
                            await helpRequestViewModel.getApprovedHelpRequests()
                        }
                    }
                }
            }
                .onAppear {
                helpRequestViewModel.readCache(userIdKey: .userId, isUnionKey: .isUnionAccount)
                Task {
                    await helpRequestViewModel.getWaitingHelpRequests()
                    await helpRequestViewModel.getApprovedHelpRequests()
                    await helpRequestViewModel.getRejectedHelpRequests()
                }
            }
        }
    }
}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestView()
    }
}

private struct CitizienHelpRequestSubView: View {
    var helpRequest: HelpRequestResponse

    var body: some View {
        VStack {
            ForEach(helpRequest, id: \.requestID) { request in
                NavigationLink {
                    CitizienHelpRequestDetail(helpRequest: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HelpRequestRow(helpRequest: request)
                }

            }
        }
    }
}

private struct UnionHelpRequestSubView: View {
    var helpRequest: HelpRequestResponse

    var body: some View {
        VStack {
            ForEach(helpRequest, id: \.requestID) { request in
                NavigationLink {
                    UnionHelpRequestDetail(helpRequest: request)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HelpRequestRow(helpRequest: request)
                }
            }
        }
    }
}



