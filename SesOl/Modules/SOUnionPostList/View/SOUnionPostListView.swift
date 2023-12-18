//
//  SOUnionPostListView.swift
//  TwitterSide
//
//  Created by Yunus Emre Berdibek on 2.05.2023.
//

import SwiftUI

struct SOUnionPostListView: View {
    @StateObject private var viewModel = SOUnionPostListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                headerView()
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.unionPosts, id: \.postID) { post in
                            NavigationLink {
                                SOUnionPostDetailView(unionPost: post)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                SOUnionPostListCell(post: post)
                                    .padding(.top, 3)
                            }
                            .foregroundColor(.dark_liver)
                        }
                    }
                }.refreshable {
                    await viewModel.getUnionPosts()
                }
                Spacer()
            }
            .onAppear {
                Task {
                    await viewModel.getUnionPosts()
                }
            }
        }
        .overlay(alignment: .center) {
            Text("Şu anda geçerli kurum gönderisi bulunmuyor. Lütfen sayfayı yenileyin veya bir süre bekleyin.")
                .padding()
        }
    }

    @ViewBuilder private func headerView() -> some View {
        Image(Icons.App.icon_dark.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 50)
        Divider()
    }
}

#Preview {
    SOUnionPostListView()
}
