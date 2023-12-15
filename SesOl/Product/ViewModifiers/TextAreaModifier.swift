//
//  TextAreaModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 7.05.2023.
//

import Foundation
import SwiftUI

struct TextAreaModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding()
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(.gray.opacity(0.5), lineWidth: 2)
            )
        
    }
}

