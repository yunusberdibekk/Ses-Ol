//
//  SystemMessageRow.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.06.2023.
//

import SwiftUI

struct SystemMessageRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "person.badge.shield.checkmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.halloween_orange)

                HStack(spacing: 5) {
                    Text("System")
                        .font(.subheadline)
                        .bold()

                    Text("@System")
                        .font(.caption)
                        .foregroundColor(.spanish_gray)
                }
            }
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)

            Text("Veritabanında ilgili veri bulunmamaktadır.")
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            
            Divider()
        }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(1), radius: 2, x: 0, y: 2)
            .padding(.leading, PagePaddings.Normal.padding_10.rawValue)
            .padding(.trailing, PagePaddings.Normal.padding_10.rawValue)

    }
}

struct SystemMessageRow_Previews: PreviewProvider {
    static var previews: some View {
        SystemMessageRow()
    }
}
