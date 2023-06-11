//
//  TextFieldModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import Foundation
import SwiftUI

/// Textfield için view modifier.
struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
            )
            .font(.callout)
            .font(.system(size: 20))
            .foregroundColor(Color.bright_gray)
    }
}
