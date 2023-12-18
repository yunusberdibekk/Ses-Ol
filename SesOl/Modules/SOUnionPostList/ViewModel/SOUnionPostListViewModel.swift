//
//  SOUnionPostListViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import Foundation

final class SOUnionPostListViewModel: ObservableObject {
    @Published var unionPosts: [UnionPostResponseElement] = []
    @Published var logStatus: Bool = false
    @Published var logMessage: String = ""

    func getUnionPosts() async {
        let response = await NetworkManager.shared.post(
            url: .unionPostCrud,
            method: .post,
            model: UnionPostRequest(
                method: RequestMethods.read_post.rawValue),
            type: [UnionPostResponseElement].self)

        switch response {
        case .success(let models):
            DispatchQueue.main.async {
                self.unionPosts = models
            }
        case .failure(let error):
            showMessage(message: error.localizedDescription)
        }
    }

    private func showMessage(message: String) {
        DispatchQueue.main.async {
            self.logMessage = message
            self.logStatus.toggle()
        }
    }

    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
