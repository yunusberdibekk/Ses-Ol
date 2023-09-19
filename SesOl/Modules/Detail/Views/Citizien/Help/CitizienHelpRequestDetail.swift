//
//  CitizienRequestDetail.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import SwiftUI

struct CitizienHelpRequestDetail: View {
    @Environment(\.dismiss) private var dismiss

    internal var helpRequest: HelpRequestResponseElement
    internal var detailViewModel: DetailViewModel = DetailViewModel()

//    internal var detailViewModel:DetailViewModel = DetailViewModel()

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
                            .foregroundColor(.spanish_gray)
                        Text(helpRequest.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)

                }.padding(.top, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)

                Text(helpRequest.requestDesc ?? "")
                    .multilineTextAlignment(.leading)
                    .padding(.all, PagePaddings.Normal.padding_20.rawValue)

                Divider().padding(.all, PagePaddings.Normal.padding_20.rawValue)

                Text("Talep Detayları")
                    .foregroundColor(.halloween_orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_10.rawValue)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Talep edilen kurum: \(helpRequest.requestUnionName ?? "")")
                    Text("Talep id: \(helpRequest.requestID ?? 1)")
                    Text("Afet kategori: \(helpRequest.requestDisasterName ?? "")")
                    Text("İrtibat no: \(helpRequest.userTel ?? "")")
                    Text("Konum: \(helpRequest.requestDistrict ?? "")/ \(helpRequest.requestCity ?? "")/\(helpRequest.requestCountry ?? "")")
                    Text("Açık adres: \(helpRequest.requestFullAddress ?? "")")
                }
                    .multilineTextAlignment(.leading)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.halloween_orange)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            detailViewModel.requestId = helpRequest.requestID!
                            Task {
                                await detailViewModel.deleteHelpRequest(request_id_value: helpRequest.requestID!)
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.halloween_orange)
                        }
                    }
                }
            }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                .padding()
        }
    }
}

struct CitizienRequestDetail_Previews: PreviewProvider {
    static var previews: some View {
        CitizienHelpRequestDetail(helpRequest: HelpRequestResponseElement(requestID: -1, requestAccountID: -1, userName: "Sample Name", userSurname: "Surname", userTel: "123456", requestUnionID: -1, requestUnionName: "Sample Union Name", requestDisasterID: -1, requestDisasterName: "Deprem", requestCategoryID: 1, requestCategoryName: "Deprem", requestNumOfPerson: -1, requestDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper. Tristique sollicitudin nibh sit amet commodo nulla. Amet venenatis urna cursus eget. Congue mauris rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar.", requestAddressID: 1, requestDistrict: "Merkez", requestCity: "Elazığ", requestCountry: "Turkiye", requestFullAddress: "Full adress", requestApproveStatus: -1))
    }
}
