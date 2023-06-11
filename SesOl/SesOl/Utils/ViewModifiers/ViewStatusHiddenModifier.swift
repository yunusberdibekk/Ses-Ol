//
//  ViewStatusHiddenModifier.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.04.2023.
//

import Foundation
import SwiftUI

/// View'ların toolbar özelliğini saklıyor.
struct ViewStatusHiddenModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.toolbar(.hidden, for: .automatic)
        } else {
            content.navigationBarBackButtonHidden(true)
        }
    }
}
