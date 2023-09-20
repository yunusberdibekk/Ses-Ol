//
//  FeedViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import Foundation

final class FeedViewModel: ObservableObject {

    @Published var unionPosts: UnionPostResponse?
    @Published var error:Bool = false
    @Published var errorMessage: NetworkError?

    func getUnionPosts() async {
        let response = await NetworkManager.shared.post(url: .unionPostCrud, method: .post, model: UnionPostRequest(method: RequestMethods.read_post.rawValue), type: UnionPostResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.unionPosts = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }

}
