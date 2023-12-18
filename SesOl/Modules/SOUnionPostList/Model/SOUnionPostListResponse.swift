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
}
