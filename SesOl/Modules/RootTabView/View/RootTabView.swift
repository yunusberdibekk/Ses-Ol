//
//  RootView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct RootTabView: View {
    @State var selection: String = TabModel.tabModels[0].id

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                ForEach(TabModel.tabModels, id: \.id) { model in
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
