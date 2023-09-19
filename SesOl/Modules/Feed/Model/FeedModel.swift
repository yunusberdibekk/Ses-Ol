//
//  FeedModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import Foundation

// MARK: - UnionPostResponseElement
struct UnionPostResponseElement: Codable {
    let postID, publisherUnionID: Int?
    let postPublisherName, postContent, postTime: String?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case publisherUnionID = "publisher_union_id"
        case postPublisherName = "post_publisher_name"
        case postContent = "post_content"
        case postTime = "post_time"
    }
}

typealias UnionPostResponse = [UnionPostResponseElement]

struct UnionPostRequest: Encodable {
    let method: String?
}
