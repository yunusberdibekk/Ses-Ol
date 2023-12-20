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
        Form {
            postOptions
            switch viewModel.unionCreateViewOption {
            case .createPost:
                createPost
                createButton
            case .posts:
                postsView
            }
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
        Section {
            ForEach(0..<viewModel.posts.count, id: \.self) { index in
                NavigationLink {
                    SOPostDetailView(
                        post: viewModel.posts[index],
                        canDelete: true,
                    index: index)
                } label: {
                    SOUnionPostListCell(post: viewModel.posts[index])
                        .padding(.bottom, 4)
                }
            }
        } header: {
            Text("KURUM GÖNDERİLER")
        }
    }
}

#Preview {
    SOUnionCreateView()
        .environmentObject(SOCreateViewModel())
}
