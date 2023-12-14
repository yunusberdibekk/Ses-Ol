//
//  RootView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct RootView: View {

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.orange
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)

        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.preferredFont(forTextStyle: .caption1)], for: .highlighted)

        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.preferredFont(forTextStyle: .caption1)], for: .normal)

        UITabBar.appearance().tintColor = UIColor(named: "halloween_orange")
    }

    private let cache = UserDefaultCache()
    @State var selectedIndex = 0

    var body: some View {

        NavigationStack {
            VStack {
                TabView(selection: $selectedIndex) {
                    FeedView().tabItem {
                        Image(systemName: "house")
                            .font(.largeTitle)
                        //   Text("Anasayfa")
                    }.tag(0)

                    HelpRequestView().tabItem {
                        Image(systemName: "person.2")
                        //  Text("Yardım Taleplerim")
                    }.tag(1)


                    PostView().tabItem {
                        Image(systemName: "plus.square.on.square")
                        //  Text("Talep Oluştur")
                    }.tag(2)

                    SupportRequestView().tabItem {
                        Image(systemName: "person.3")
                        // Text("Destek Taleplerim")
                    }.tag(3)

                    ProfileView().tabItem {
                        Image(systemName: "person")
                        //Text("Profil")
                    }.tag(4)
                }.tabViewStyle(.automatic)
                    .tint(.halloween_orange)
            }
        }
    }
}
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
