//
//  OnBoardView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import SwiftUI

struct OnboardView: View {
    @ObservedObject var onboardViewModel = OnboardViewModel()

    /// Dummy list count
    /// - Returns: Total item count without last item
    private func count() -> Int {
        OnboardModel.items.count - 1
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    TabView(
                        selection: $onboardViewModel.currentIndex,
                        content: {
                            ForEach((0...count()), id: \.self) { value in
                                SliderCard(imageHeight: geometry.dh(height: 0.5),
                                    model
                                    : OnboardModel.items[value]
                                )
                            }
                        })
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    Spacer()
                    HStack {
                        ForEach((0...count()), id: \.self) { index in
                            IndicatorRectangle(width: index == onboardViewModel.currentIndex ? geometry.dw(width: 0.09) : geometry.dw(width: 0.03))
                            
                        }
                    }.frame(height: ViewHeight.indicator)
                    
                    CustomButton(onTap: {
                        onboardViewModel.saveUserLoginAndRedirect()
                    }, title: "Hadi Başla").padding(.all, PagePaddings.All.normal.rawValue)
                        .onAppear {
                        onboardViewModel.checkUserFirstTime()
                    }
                }.navigationDestination(isPresented: $onboardViewModel.isHomeRedirect) {
                    LoginView()
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

private struct SliderCard: View {
    var imageHeight: Double
    let model: OnboardModel
    var body: some View {
        VStack {
            Image(model.imageName)
                .resizable()
                .frame(height: imageHeight)
            Text(model.description)
                .font(.system(size: FontSizes.largeTitle, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.halloween_orange)
                .padding(.all, PagePaddings.All.normal.rawValue)
        }
    }
}

private struct IndicatorRectangle: View {
    var width: Double
    var body: some View {
        Rectangle()
            .fill(Color.argent)
            .cornerRadius(RadiusItems.radius).frame(width: width)
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}

