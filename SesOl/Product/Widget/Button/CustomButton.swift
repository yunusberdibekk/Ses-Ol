//
//  NormalButton.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

///
/// [onTap] yapılacak olan işlem.
/// [title] button ismi
struct CustomButton: View {
    var onTap: () -> Void
    var title: String

    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Spacer()
                Text(title)
                Spacer()
            }
                .tint(.white)
                .font(.system(size: FontSizes.headline, weight: .semibold))
                .padding(.all, PagePaddings.All.normal.rawValue)

        }
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            .background(Color.halloween_orange)
            .cornerRadius(RadiusItems.radius)

    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(onTap: {

        }, title: "Sample")
    }
}
