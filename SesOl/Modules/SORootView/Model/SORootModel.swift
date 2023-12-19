//
//  SORootModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 17.12.2023.
//

import SwiftUI

struct SORootModel: Identifiable {
    let id: String
    let view: AnyView
    let tabItem: SORootTabItem

    static let tabModels: [SORootModel] = [
        .init(id: UUID().uuidString,
              view: AnyView(SOUnionPostListView()),
              tabItem: .init(title: "Feed",
                             icon: "house.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(SOHelpRequestListView()),
              tabItem: .init(title: "Requests",
                             icon: "list.bullet.clipboard.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(SOCreateView()),
              tabItem: .init(title: "Create",
                             icon: "plus.square.on.square")),
//        .init(id: UUID().uuidString,
//              view: AnyView(SupportRequestView()),
//              tabItem: .init(title: "Support Requests",
//                             icon: "list.bullet.rectangle.portrait.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(ProfileView()),
              tabItem: .init(title: "Profile",
                             icon: "person.fill")),
    ]
}

struct SORootTabItem {
    let title: String
    let icon: String
}
