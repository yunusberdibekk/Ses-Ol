//
//  RootTabModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 17.12.2023.
//

import SwiftUI

struct TabModel: Identifiable {
    let id: String
    let view: AnyView
    let tabItem: TabItem

    static let tabModels: [TabModel] = [
        .init(id: UUID().uuidString,
              view: AnyView(FeedView()),
              tabItem: .init(title: "Feed",
                             icon: "house.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(HelpRequestView()),
              tabItem: .init(title: "Requests",
                             icon: "list.bullet.clipboard.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(PostView()),
              tabItem: .init(title: "Create",
                             icon: "plus.square.on.square")),
        .init(id: UUID().uuidString,
              view: AnyView(SupportRequestView()),
              tabItem: .init(title: "Support Requests",
                             icon: "list.bullet.rectangle.portrait.fill")),
        .init(id: UUID().uuidString,
              view: AnyView(ProfileView()),
              tabItem: .init(title: "Profile",
                             icon: "person.fill")),
    ]
}

struct TabItem {
    let title: String
    let icon: String
}
