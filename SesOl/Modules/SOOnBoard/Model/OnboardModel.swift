//
//  OnBoardModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 21.04.2023.
//

import Foundation

struct OnboardModel: Identifiable {
    var id: UUID = .init()
    let imageName: String
    let description: String

    static let items: [OnboardModel] = [
        OnboardModel(imageName: Images.Auth.onBoard1.rawValue,
                     description: "Meydana gelen afetlerden sonra ihtiyaçlarını belirle ve paylaş."),
        OnboardModel(imageName: Images.Auth.onBoard2.rawValue,
                     description: "Afetzedelerin oluşturduğu yardım taleplerine karşılık ver."),
        OnboardModel(imageName: Images.Auth.onBoard3.rawValue,
                     description: "Onaylanmış kurumlar ile süreci yöneterek koordi-nasyonu sağla."),
    ]
}
