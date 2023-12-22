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

    static let mockPostElement1: UnionPostResponseElement = .init(
        postID: 1,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement1.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement1.unionName,
        postContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque.",
        postTime: "20 Aralık 2023, Çarşamba (GMT+3)")

    static let mockPostElement2: UnionPostResponseElement = .init(
        postID: 2,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement2.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement2.unionName,
        postContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eu feugiat dui. Vestibulum eu accumsan justo. Phasellus ut ex et turpis pretium porttitor sed non est. Duis volutpat porta lacus nec fermentum. Cras quis lectus magna. Mauris malesuada hendrerit tortor, quis commodo sem molestie et.",
        postTime: "21 Aralık 2023, Perşembe (GMT+3)")

    static let mockPostElement3: UnionPostResponseElement = .init(
        postID: 3,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement3.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement3.unionName,
        postContent: "Praesent sed dui et arcu malesuada malesuada vel vel nisl. Suspendisse porttitor dui ante, at sollicitudin eros rhoncus consequat. Vivamus porttitor lorem non pellentesque rutrum. Nulla tempor sagittis lectus in eleifend. Donec a neque elementum, efficitur erat at, porttitor odio. Sed rhoncus ornare arcu in hendrerit.",
        postTime: "21 Aralık 2023, Perşembe (GMT+3)")

    static let mockPostElement4: UnionPostResponseElement = .init(
        postID: 4,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement2.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement2.unionName,
        postContent: "Vivamus tempor elementum elit ut elementum. Vestibulum vel ligula eget ex venenatis lacinia. Nunc ut maximus augue, eget finibus velit. Donec rhoncus nisi eu purus luctus ultricies. Quisque in est dignissim, cursus nisi eu, tempus metus. Nulla nec nisi porttitor, eleifend dolor a, consectetur nibh. ",
        postTime: "22 Aralık 2023, Cuma (GMT+3)")

    static let mockPostElement5: UnionPostResponseElement = .init(
        postID: 5,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement1.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement1.unionName,
        postContent: " Sed cursus purus quam, vitae pulvinar dolor venenatis vel. Sed auctor leo vitae enim egestas, et ultrices mauris facilisis. Sed et sem magna. In ornare dignissim auctor.",
        postTime: "22 Aralık 2023, Cuma (GMT+3)")

    static let mockPostElement6: UnionPostResponseElement = .init(
        postID: 6,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement2.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement2.unionName,
        postContent: "Ut id consequat turpis, eget fringilla tellus. Cras at sapien sed ex pretium dictum vitae eget diam. Integer dignissim nulla felis, a sodales massa dapibus a. ",
        postTime: "23 Aralık 2023, Cumartesi (GMT+3)")

    static let mockPostElement7: UnionPostResponseElement = .init(
        postID: 7,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement3.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement3.unionName,
        postContent: "Phasellus volutpat nisl quis posuere varius. Maecenas et diam a felis placerat aliquam nec vitae velit. Nam sit amet dictum turpis. Mauris leo nisl, vestibulum et mi eget, dictum tristique massa. Vestibulum ac ligula sollicitudin libero ullamcorper viverra. Nulla vitae dui eu urna mollis luctus sit amet quis ex. Mauris auctor tincidunt aliquam. ",
        postTime: "23 Aralık 2023, Cumartesi (GMT+3)")

    static let mockPostElement8: UnionPostResponseElement = .init(
        postID: 8,
        publisherUnionID: UnionResponseElement.mockUnionResponseElement3.id,
        postPublisherName: UnionResponseElement.mockUnionResponseElement3.unionName,
        postContent: "Maecenas consequat hendrerit tellus eu laoreet. Quisque lobortis tortor quis lectus luctus hendrerit. In volutpat lectus sed ante egestas, vitae varius est venenatis.",
        postTime: "24 Aralık 2023, Pazar (GMT+3)")

    static let mockUnionPostElements: [UnionPostResponseElement] = [
        .mockPostElement1,
        .mockPostElement2,
        .mockPostElement3,
        .mockPostElement4,
        .mockPostElement5,
        .mockPostElement6,
        .mockPostElement7,
        .mockPostElement8,
    ]
}
