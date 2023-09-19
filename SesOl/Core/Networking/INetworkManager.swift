//
//  INetworkManager.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Foundation

protocol INetworkManager {
    func fetch<T: Codable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T, NetworkError>
    func post<T:Codable, R:Encodable>(url: NetworkPath, method: NetworkType, model: R, type: T.Type)async -> Result<T, NetworkError>
    func auth<T:Codable, R:Encodable>(url: NetworkPath, method: NetworkType, model: R, type: T.Type)async -> Result<T, AuthError>
    
    var config: NetworkConfig { get set }
}
