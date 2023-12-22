//
//  SOHelpRequestCell.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import SwiftUI

struct SOHelpRequestCell: View {
    var helpRequest: HelpRequestResponseElement

    private var headerView: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .foregroundColor(.halloween_orange)

            HStack(spacing: 5) {
                HStack(spacing: 3) {
                    Text(helpRequest.userName)
                    Text(helpRequest.userSurname)
                }
                .font(.subheadline).bold()

                HStack(spacing: 0) {
                    Text("@")
                    Text(helpRequest.userTel)
                }
                .font(.caption)
                .foregroundColor(.spanish_gray)
            }
        }
    }

    private func bodyView() -> some View {
        VStack {
            Text(helpRequest.requestDesc)
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            Divider()
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
            bodyView()
        }
        .modifier(RequestCellModifier())
    }
}

struct HelpRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        SOHelpRequestCell(helpRequest: HelpRequestResponseElement.dummyHelpRequestResponseElement1)
    }
}
