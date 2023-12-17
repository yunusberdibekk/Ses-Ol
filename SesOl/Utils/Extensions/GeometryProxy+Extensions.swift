//
//  GeometryProxy+Extensions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

extension GeometryProxy {
    /// Cihazdan cihaza değişen dinamik yükseklik.
    /// - Parameter height
    /// - Returns: Kullanılan ekrana göre hesaplanmış yükseklik değeri.
    func dh(height: Double) -> Double {
        return size.height * height
    }

    /// Cihazdan cihaza değişen dinamik genişlik.
    /// - Parameter width
    /// - Returns: Kullanılan ekrana göre hesaplanmış genişlik değeri.
    func dw(width: Double) -> Double {
        return size.width * width
    }
}
