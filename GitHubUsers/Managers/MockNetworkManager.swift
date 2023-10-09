//
//  MockNetworkManager.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/09.
//

import Alamofire
import Foundation
import Combine

class MockNetworkManager: NetworkManagerProtocol {
    
    // properties to store the mock result's Element and AFError
    var mockResultElement: Any? = nil
    var mockResultAFError: AFError? = nil
    
    func sendRequest<Element: Decodable>(endpoint: EndPoint) async -> Result<Element, AFError> {
        // check if there is an error
        if let _ = mockResultAFError {
            return .failure(.explicitlyCancelled)
        }
        
        // Check if a mock response is set, otherwise return an empty result
        guard let mockResultElement = mockResultElement else {
            return .failure(.explicitlyCancelled)
        }
        
        // You should cast the mock response to the expected result type (Result<Element, AFError>)
        if let mockElement = mockResultElement as? Element {
            return .success(mockElement)
        } else {
            return .failure(.explicitlyCancelled)
        }
    }
}
