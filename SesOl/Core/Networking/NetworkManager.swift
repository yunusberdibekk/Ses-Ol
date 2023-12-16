//
//  NetworkManager.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import Alamofire
import Foundation

final class NetworkManager: INetworkManager {
    var config: NetworkConfig

    init(config: NetworkConfig) {
        self.config = config
    }

    static let shared = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))

    /// Generic fetch function.
    /// - Parameters:
    ///   - url: Request url
    ///   - method: [.get or .post]
    ///   - type: Generic response type
    /// - Returns: It will return Result<T, Error>
    func fetch<T: Codable>(url: NetworkPath, method: NetworkType, type: T.Type) async -> Result<T, NetworkError> {
        let request = AF.request("\(config.baseUrl)\(url.rawValue)", method: method.toAF())
            .validate()
            .serializingDecodable(T.self)

        let result = await request.response

        guard let data = result.value else {
            return .failure(.networkError(description: "The data is empty."))
        }
        return .success(data)
    }

    /// Generic post function
    /// - Parameters:
    ///   - url: Request url
    ///   - method: [.post, or .get]]
    ///   - model: Model to be translated as a dictionary
    ///   - type: Generic response type
    /// - Returns: It will save data to the database. It will forward the response returned as a result of this process.
    func post<T: Codable, R: Encodable>(url: NetworkPath, method: NetworkType, model: R, type: T.Type) async -> Result<T, NetworkError> {
        let jsonEncoder = JSONEncoder()

        guard let data = try? jsonEncoder.encode(model) else {
            return .failure(.networkError(description: "An error occurred during the encode process"))
        }

        guard let dataString = String(data: data, encoding: .utf8) else {
            return .failure(.networkError(description: "An error occurred while converting data to string"))
        }

        let dataRequest = AF.request("\(config.baseUrl)\(url.rawValue)", method: method.toAF(), parameters: convertToDictionary(text: dataString))
            .validate()
            .serializingDecodable(T.self)

        let result = await dataRequest.response

        guard let data = result.value else {
            return .failure(.networkError(description: "The data is empty."))
        }

        return .success(data)
    }

    /// Custom  modifier auth  function
    /// - Parameters:
    ///   - url: Request url
    ///   - method: [.post, or .get]]
    ///   - model: Model to be translated as a dictionary
    ///   - type: Generic response type
    /// - Returns: It will save data to the database. It will forward the response returned as a result of this process.
    func auth<T: Codable, R: Encodable>(url: NetworkPath, method: NetworkType, model: R, type: T.Type) async -> Result<T, AuthError> {
        let jsonEncoder = JSONEncoder()

        guard let data = try? jsonEncoder.encode(model) else {
            return .failure(.networkError(description: "An error occurred during the encode process"))
        }

        guard let dataString = String(data: data, encoding: .utf8) else {
            return .failure(.networkError(description: "An error occurred while converting data to string"))
        }

        let dataRequest = AF.request("\(config.baseUrl)\(url.rawValue)", method: method.toAF(), parameters: convertToDictionary(text: dataString))
            .validate()
            .serializingDecodable(T.self)

        let result = await dataRequest.response

        guard let data = result.value else {
            return .failure(.networkError(description: "The data is empty."))
        }

        return .success(data)
    }

    /// It will convert the model to dictionary data type
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
