//
//  SOUnionCreateView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

struct SOUnionCreateView: View {
    @EnvironmentObject var viewModel: SOCreateViewModel

    var body: some View {
        switch viewModel.unionCreateViewOption {
        case .createPost:
            Form {
                postOptions
                createPost
                createButton
            }
            .task { await viewModel.fetchAdditionalUnionPosts() }
        case .posts:
            unionPostOptions
            postsView
        }
    }

    private var postOptions: some View {
        Section {
            Picker("Seç", selection: $viewModel.unionCreateViewOption) {
                ForEach(UnionCreateViewOptions.allCases, id: \.self) { option in
                    Text(option.description)
                        .tag(option)
                }
            }
        }
    }

    private var unionPostOptions: some View {
        Picker("Seç", selection: $viewModel.unionCreateViewOption) {
            ForEach(UnionCreateViewOptions.allCases, id: \.self) { option in
                Text(option.description)
                    .tag(option)
            }
        }
        .pickerStyle(.automatic)
        .padding([.top, .bottom], 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var createPost: some View {
        Section {
            TextEditor(text: $viewModel.postDesc)
        } header: {
            Text("GÖNDERİ AÇIKLAMASI")
        }
    }

    private var createButton: some View {
        Button("Share") {
            Task {
                await viewModel.createUnionPost()
            }
        }
        .modifier(DefaultListButtonModifier(backgroundColor: .blue))
    }

    private var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(0 ... viewModel.posts.count - 1, id: \.self) { index in
                    NavigationLink {
                        SOCreateUnionPostDetailView(
                            post: viewModel.posts[index],
                            index: index)
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(viewModel)
                    } label: {
                        SOUnionPostListCell(post: viewModel.posts[index])
                            .padding(.bottom, 4)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .task { await viewModel.fetchAdditionalUnionPosts() }
    }
}

#Preview {
    SOUnionCreateView()
        .environmentObject(SOCreateViewModel())
}
