//
//  SupportRequestRow.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct SupportRequestRow: View {
    var supportRequest: ProvidingAssistanceResponseElement

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.halloween_orange)

                HStack(spacing: 5) {
                    Text(supportRequest.fullname ?? "")
                        .font(.subheadline).bold()

                    HStack(spacing: 0) {
                        Text("@")
                        Text(supportRequest.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)
                }
            }
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)

            Text(supportRequest.assistanceDescription ?? "Hata")
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            
            Divider()
        }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(1), radius: 5, x: 0, y: 2)
            .padding(.all, PagePaddings.Normal.padding_10.rawValue)
    }
}


struct SupportRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        SupportRequestRow(supportRequest: ProvidingAssistanceResponseElement(assistanceID: -1, assistanceTitle: "", assistanceSentUnionID: 1, assistanceSentUnionName: "Afad", assistanceUserAccountID: -1, userTel: "+90 561 616 09 72", assistanceNumOfPerson: 0, assistanceCategoryID: -1, assistanceCategoryName: "", asistanceStatus: -1, assistanceDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", fullname: "Rahmi Toprak", addressID: -1, addressDistrict: "", addressCity: "", addressCountry: "", fullAddress: "", assistanceStatus: -1))
    }
}
