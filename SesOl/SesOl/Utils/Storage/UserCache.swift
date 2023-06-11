//
//  UserCacheItems.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 23.04.2023.
//

import Foundation

/// Kaydedilen kullanıcı anahtarları.
enum UserCacheKeys: String {
    case onboard = "onboard"
    case userId = "userId"
    case isUnionAccount = "isUnionAccount"
    static let dummyValue = "save_onboard"
}

/// UserDefault protocol fonksiyonları.
protocol IUserCache {
    func read(key: UserCacheKeys) -> String
    func save(key: UserCacheKeys, value: String)
    func remove(key: UserCacheKeys)
    
}

extension IUserCache {
    /// Verilen key'e göre veriyi okumak.
    /// - Parameter key: cache key verisi
    /// - Returns: key e göre kaydedilen veri veya nil.
    func read(key: UserCacheKeys) -> String {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) as? String else {return ""}
        return value
    }
    
    /// Verilen key'e göre veriyi kaydetmek.
    /// - Parameters:
    ///   - key: cache key verisi
    ///   - value: herhangi bir string verisi
    func save(key: UserCacheKeys, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    /// Verilen key'e göre veriyi silmek.
    /// - Parameter key: cache key verisi
    func remove(key: UserCacheKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}

struct UserDefaultCache: IUserCache {}


