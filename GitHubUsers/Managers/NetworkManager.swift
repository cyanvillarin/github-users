//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/08.
//

import Alamofire
import Combine

class NetworkManager: NetworkManagerProtocol {
    /// an async function with generic type
    /// - Parameter endpoint: the API endpoint we want to cal
    /// - Returns: the Result containing the response, and the error (if any)
    func sendRequest<Element: Decodable>(endpoint: EndPoint) async -> Result<Element, AFError> {
        let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"]
        guard let accessToken else { return .failure(.explicitlyCancelled) }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        let result = await AF.request(endpoint.urlString, method: endpoint.httpMethod, headers: headers)
            .serializingDecodable(Element.self)
            .result
        
        switch result {
            case .success(let data):
                return .success(data)
            case .failure(let error):
                return .failure(error)
        }
    }
}
