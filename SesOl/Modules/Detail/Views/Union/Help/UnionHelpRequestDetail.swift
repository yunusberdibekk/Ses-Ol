//
//  UnionHelpRequestDetail.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import SwiftUI

struct UnionHelpRequestDetail: View {
    @Environment(\.dismiss) private var dismiss
    var helpRequest: HelpRequestResponseElement

    @StateObject private var detailViewModel = DetailViewModel()
    @StateObject private var postViewModel = PostViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.halloween_orange)

                    HStack(spacing: 3) {
                        Text(helpRequest.userName ?? "")
                        Text(helpRequest.userSurname ?? "")
                    }
                        .font(.subheadline)
                        .bold()

                    HStack(spacing: 0) {
                        Text("@")
                        Text(helpRequest.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)

                }.padding(.top, 20)
                    .padding(.leading, 20)

                Text(helpRequest.requestDesc ?? "")
                    .multilineTextAlignment(.leading)
                    .padding(.all, 20)

                Divider().padding(.all, 20)

                Text("Talep Detayları")
                    .foregroundColor(.halloween_orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.leading, 20)
                    .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Talep edilen kurum: \(helpRequest.requestUnionName ?? "")")
                    Text("Afet kategori: \(helpRequest.requestDisasterName ?? "")")
                    Text("İrtibat no: \(helpRequest.userTel ?? "")")
                    Text("Konum: \(helpRequest.requestDistrict ?? "")/ \(helpRequest.requestCity ?? "")/\(helpRequest.requestCountry ?? "")")
                    Text("Açık adres: \(helpRequest.requestFullAddress ?? "")")
                }
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .toolbar {

                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.halloween_orange)
                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            detailViewModel.requestId = helpRequest.requestID!
                            Task {
                                await detailViewModel.approveRequest()
                                dismiss()
                            }

                            Task {

                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .frame(width: 25, height: 20)
                                .foregroundColor(.green)
                        }

                        Button {
                            detailViewModel.requestId = helpRequest.requestID!
                            Task {
                                await detailViewModel.rejectRequest()
                                dismiss()
                            } } label: {
                            Image(systemName: "multiply")
                                .frame(width: 25, height: 20)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                .padding()
        }
    }
}

struct UnionHelpRequestDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnionHelpRequestDetail(helpRequest: HelpRequestResponseElement(requestID: -1, requestAccountID: -1, userName: "Sample Name", userSurname: "Surname", userTel: "123456", requestUnionID: -1, requestUnionName: "Sample Union Name", requestDisasterID: -1, requestDisasterName: "Deprem", requestCategoryID: 1, requestCategoryName: "Deprem", requestNumOfPerson: -1, requestDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper. Tristique sollicitudin nibh sit amet commodo nulla. Amet venenatis urna cursus eget. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar.", requestAddressID: 1, requestDistrict: "Merkez", requestCity: "Elazığ", requestCountry: "Turkiye", requestFullAddress: "Full adress", requestApproveStatus: -1))
    }
}
