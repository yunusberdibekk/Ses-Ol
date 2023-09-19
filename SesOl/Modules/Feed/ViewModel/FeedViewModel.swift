//
//  FeedViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import Foundation

final class FeedViewModel: ObservableObject {

    @Published var unionPosts: UnionPostResponse? = nil
    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))

    func getUnionPosts() async {
        let posts = await getAllUnionPosts(method: "read_post")

        DispatchQueue.main.async {
            self.unionPosts = posts
        }
    }

    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

}

extension FeedViewModel {
    func getAllUnionPosts(method: String) async -> UnionPostResponse? {
        guard let response = await networkManager.post(path: .unionPostCrud, model: UnionPostRequest(method: method), type: UnionPostResponse.self) else { return nil }

        return response
    }
}

protocol IFeedViewModel {
    func getAllUnionPosts(method: String) async -> UnionPostResponse?
}
