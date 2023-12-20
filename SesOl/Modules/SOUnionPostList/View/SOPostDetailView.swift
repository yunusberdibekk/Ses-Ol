//
//  SOPostDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 8.05.2023.
//

import SwiftUI

struct SOPostDetailView: View {
    @EnvironmentObject var viewModel: SOCreateViewModel
    @Environment(\.dismiss) private var dismiss
    let post: UnionPostResponseElement
    let canDelete: Bool
    let index: Int

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "person.badge.shield.checkmark.fill")
                        .font(.title2)
                        .foregroundColor(.halloween_orange)
                    Text(post.postPublisherName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(post.postTime)
                        .foregroundColor(.spanish_gray)
                        .font(.caption)
                    Spacer()
                }
                .padding([.top, .leading], PagePaddings.Normal.padding_20.rawValue)
                Text(post.postContent)
                    .foregroundColor(.dark_liver)
                    .multilineTextAlignment(.leading)
                    .padding(.all, PagePaddings.Normal.padding_20.rawValue)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.halloween_orange)
                            }
                        }

                        if viewModel.canDelete(unionID: post.publisherUnionID) && canDelete {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    Task {
                                        await viewModel.deleteUnionPost(postID: post.postID, index: index)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.halloween_orange)
                                }
                            }
                        }
                    }
                Divider()
            }
            .modifier(RequestCellModifier())
        }
    }
}

#Preview {
    SOPostDetailView(
        post: UnionPostResponseElement.mockPostElement,
        canDelete: true,
        index: 0)
        .environmentObject(SOCreateViewModel())
}
