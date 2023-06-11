//
//  FeedView.swift
//  TwitterSide
//
//  Created by Yunus Emre Berdibek on 2.05.2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var feedViewModel = FeedViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Image(Icons.App.icon_dark.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 50)
                Divider()

                ScrollView {
                    LazyVStack {
                        if let posts = feedViewModel.unionPosts {
                            ForEach(posts, id: \.postID) { post in
                                NavigationLink {
                                    PostDetailView(unionPost: post)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    PostRow(post: post)
                                        .padding(.top, 3)
                                }.foregroundColor(.dark_liver)
                            }
                        } else {
                            let currentTime = feedViewModel.getCurrentTime()

                            PostRow(post: UnionPostResponseElement(postID: -1, publisherUnionID: -1, postPublisherName: "System", postContent: "Dikkat! Şu anda sistem veri tabanında yayımlanmış kurum post girişi bulunmamaktadır.", postTime: currentTime))
                        }
                    }
                }.refreshable {
                    await feedViewModel.getUnionPosts()
                }
                Spacer()
            }.onAppear {
                Task {
                    await feedViewModel.getUnionPosts()
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

