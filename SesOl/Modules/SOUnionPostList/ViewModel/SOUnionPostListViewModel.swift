//
//  SOUnionPostListViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 25.05.2023.
//

import SwiftUI

final class SOUnionPostListViewModel: ObservableObject {
    @AppStorage("userType") var userType: UserType = .citizien
    @AppStorage("userID") var userID = 0
    @Published var unionPosts: [UnionPostResponseElement] = []
    @Published var logStatus: Bool = false
    @Published var logMessage: String = ""

    @Published var mockUnionPosts: [UnionPostResponseElement] = UnionPostResponseElement.mockUnionPostElements

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
