//
//  Images.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

/// Uygulama içinde yer alan resimlerin yolları bulunuyor.
struct Images {
    enum Auth: String {
        case onBoard1 = "img_disaster"
        case onBoard2 = "img_support"
        case onBoard3 = "img_control"
    }
    
    
    
}


extension String {
    /// Parametre olarak gelen string resim'e dönüşüyor.
    /// - Returns: Gelen string adres'in resmi.
    func toImage() -> Image  {
        return Image(self)
    }
}
