//
//  TextModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.05.2023.
//

import Foundation
import SwiftUI

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            }.foregroundColor(Color.bright_gray)
        
    }
}
