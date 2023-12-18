//
//  Icons.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import Foundation

/// Uygulama içinde yer alan iconların yolları bulunuyor.
enum Icons {
    enum App: String {
        case icon_white = "app_icon_white"
        case icon_dark = "app_icon_dark"
    }

    enum Auth: String {
        case icon_tel = "phone.fill"
        case icon_lock = "lock.fill"
    }

    enum TabView: String {
        case home = "house"
        case help_request = "person.2"
        case post = "iplus.square.on.square"
        case support_request = "person.3"
        case profile = "person"
    }
}
