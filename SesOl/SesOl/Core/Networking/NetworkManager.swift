//
//  NetworkManager.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 23.04.2023.
//

import Alamofire
import SwiftUI
import Foundation

protocol INetworkManager {
    func fetch<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type) async -> T?
    func post<T: Codable, R:Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T?
    var config: NetworkConfig { get set }
}

extension NetworkManager {
    static let networkManager: INetworkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
}

class NetworkManager: INetworkManager {

    internal var config: NetworkConfig

    init(config: NetworkConfig) {
        self.config = config
    }

    func fetch<T: Codable>(path: NetworkPath, method: HTTPMethod, type: T.Type) async -> T? {
        let dataRequest = AF.request("\(config.baseUrl)\(path.rawValue)", method: method)
            .validate()
            .serializingDecodable(T.self)

        let result = await dataRequest.response

        guard let value = result.value else {
            print("ERROR: \(String(describing: result.error))")
            return nil
        }

        return value
    }

    func post<T: Codable, R:Encodable>(path: NetworkPath, model: R, type: T.Type) async -> T? {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(model) else { return nil }
        guard let dataString = String(data: data, encoding: .utf8) else { return nil }


        let dataRequest = AF.request("\(config.baseUrl)\(path.rawValue)", method: .get, parameters: convertToDictionary(text: dataString))
            .validate()
            .serializingDecodable(T.self)

        let result = await dataRequest.response
        
        do {
            let value = result.value
            return value
        } catch {
            print("Error: \(String(describing: result.error))")
            return nil
        }
    }

    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
