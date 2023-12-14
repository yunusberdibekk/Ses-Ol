//
//  UnionPostRow.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import SwiftUI

struct PostRow: View {
    var post: UnionPostResponseElement

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "person.badge.shield.checkmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.halloween_orange)

                HStack(spacing: 5) {
                    Text(post.postPublisherName ?? "")
                        .font(.subheadline)
                        .bold()

                    Text(post.postTime ?? "")
                        .font(.caption)
                        .foregroundColor(.spanish_gray)
                }
            }
                .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)

            Text(post.postContent ?? "")
                .font(.subheadline)
                .foregroundColor(.dark_liver)
                .multilineTextAlignment(.leading)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
            
            Divider()
        }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(1), radius: 2, x: 0, y: 2)
            .padding(.leading, PagePaddings.Normal.padding_10.rawValue)
            .padding(.trailing, PagePaddings.Normal.padding_10.rawValue)

    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: UnionPostResponseElement(postID: 1, publisherUnionID: 1, postPublisherName: "Afad", postContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", postTime: "2023-05-23 18:16:34"))
    }
}
