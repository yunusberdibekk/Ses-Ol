//
//  SOOnboardView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

struct SOOnboardView: View {
    @AppStorage("isOnBoarding") var isOnBoarding = false

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(resource: .halloweenOrange)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(resource: .argent)
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    TabView(content: {
                        ForEach(OnboardModel.items, id: \.id) { item in
                            onBoardItem(
                                height: geometry.dh(height: 0.5),
                                model: item)
                        }
                    })
                    .tabViewStyle(.page)
                    Spacer()
                    CustomButton(onTap: {
                        isOnBoarding = true
                    }, title: "Hadi Başla").padding(.all, PagePaddings.All.normal.rawValue)
                }
            }
        }
    }

    @ViewBuilder func onBoardItem(height: Double, model: OnboardModel) -> some View {
        VStack {
            Image(model.imageName)
                .resizable()
                .frame(height: height)
            Text(model.description)
                .font(.system(size: FontSizes.largeTitle,
                              weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.halloween_orange)
                .padding(.all, PagePaddings.All.normal.rawValue)
        }
    }
}

#Preview {
    SOOnboardView()
}
