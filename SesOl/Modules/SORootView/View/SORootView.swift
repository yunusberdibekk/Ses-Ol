//
//  SORootView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct SORootView: View {
    @State var selection: String = SORootModel.tabModels[0].id

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                ForEach(SORootModel.tabModels, id: \.id) { model in
                    model.view
                        .tabItem {
                            Label(model.tabItem.title,
                                  systemImage: model.tabItem.icon)
                        }
                        .tag(model.id)
                }
            }
            .tint(.halloween_orange)
        }
    }
}

#Preview {
    SORootView()
}
