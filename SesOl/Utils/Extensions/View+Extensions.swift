//
//  View+Extensions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

extension View {
    func customListButton(action: @escaping () -> Void) -> some View {
        Button("Paylaş") {
            action()
        }
        .modifier(DefaultListButtonModifier(backgroundColor: .blue))
    }
}
