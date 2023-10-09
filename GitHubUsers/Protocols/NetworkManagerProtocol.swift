//
//  NetworkManagerProtocol.swift
//  GitHubUsers
//
//  Created by Cyan Villyan  on 2023/10/09.
//

import Combine
import Alamofire

protocol NetworkManagerProtocol {
    func sendRequest<Element: Decodable>(endpoint: EndPoint) async -> Result<Element, AFError>
}
