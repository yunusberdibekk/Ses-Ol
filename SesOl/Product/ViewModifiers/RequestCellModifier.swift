//
//  RequestCellModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 18.12.2023.
//

import Foundation
import SwiftUI

/// RequestCell için view modifier.
struct RequestCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}
