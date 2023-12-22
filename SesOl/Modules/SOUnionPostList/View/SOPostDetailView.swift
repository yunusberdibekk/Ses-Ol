//
//  SOPostDetailView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.12.2023.
//

import SwiftUI

struct SOPostDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let post: UnionPostResponseElement

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

                Divider()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.halloween_orange)
                    }
                }
            }
            .modifier(RequestCellModifier())
        }
    }
}

#Preview {
    SOPostDetailView(
        post: UnionPostResponseElement.mockPostElement1)
}
