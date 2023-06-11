//
//  HelpRequestRow.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import SwiftUI

struct HelpRequestRow: View {
    var helpRequest: HelpRequestResponseElement

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.halloween_orange)

                HStack(spacing: 5) {
                    HStack(spacing: 3) {
                        Text(helpRequest.userName ?? "")
                        Text(helpRequest.userSurname ?? "")
                    }
                        .font(.subheadline).bold()

                    HStack(spacing: 0) {
                        Text("@")
                        Text(helpRequest.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)
                }
            }
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)

            Text(helpRequest.requestDesc ?? "Hata")
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            Divider()

        }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(1), radius: 2, x: 0, y: 2)
            .padding(.all, PagePaddings.Normal.padding_10.rawValue)
    }
}

struct HelpRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestRow(helpRequest: HelpRequestResponseElement(requestID: 1, requestAccountID: 8, userName: "Rahmi", userSurname: "Toprak", userTel: "+90 561 616 09 72", requestUnionID: 1, requestUnionName: "AFAD", requestDisasterID: 1, requestDisasterName: "Deprem", requestCategoryID: 1, requestCategoryName: "Hijyen", requestNumOfPerson: 10, requestDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", requestAddressID: 1, requestDistrict: "Beyoğlu", requestCity: "İstanbul", requestCountry: "Türkiye", requestFullAddress: "Sample Full Adress", requestApproveStatus: -1))
    }
}
