//
//  DefaultListButtonModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

struct DefaultListButtonModifier: ViewModifier {
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
    }
}
