//
//  FeedResponse.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 17.12.2023.
//

import Foundation

struct UnionPostResponseElement: Codable {
    let postID, publisherUnionID: Int
    let postPublisherName, postContent, postTime: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case publisherUnionID = "publisher_union_id"
        case postPublisherName = "post_publisher_name"
        case postContent = "post_content"
        case postTime = "post_time"
    }

    static let mockPostElement: UnionPostResponseElement = .init(
        postID: 1,
        publisherUnionID: 1,
        postPublisherName: "AFAD",
        postContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque.",
        postTime: "20 Aralık 2023, Çarşamba (GMT+3)")
}
