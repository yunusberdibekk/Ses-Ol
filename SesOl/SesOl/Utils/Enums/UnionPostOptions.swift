//
//  UnionPostOptions.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 9.06.2023.
//

import Foundation

enum UnionPostOptions: Int, CaseIterable {
    case createPost = 0
    case posts = 1
    
    var description: String {
        switch self {
        case .createPost:
            return "Gönderi Oluştur"
        case .posts:
            return "Gönderiler"
      
        }
    }
}
