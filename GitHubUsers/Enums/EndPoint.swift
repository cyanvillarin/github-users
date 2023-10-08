//
//  EndPoint.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/08.
//

import Alamofire

enum EndPoint {
    
    // lastUserId refers to the id where the list will start
    case getUsers(lastUserId: Int64)
    case getUserDetails(userName: String)
    case getRepositories(userName: String, currentPage: Int)
    
    // the query parameters for each endpoint
    var queryParams: String? {
        switch self {
        case .getUsers(let lastUserId):
            return "per_page=\(NetworkManager.usersPageLimit)&since=\(lastUserId)"
        case .getUserDetails:
            return nil
        case .getRepositories(_ , let currentPage):
            return "per_page=\(NetworkManager.reposPageLimit)&page=\(currentPage)"
        }
    }
    
    // the urlString to be used, add queryParams if needed
    var urlString: String {
        let baseUrl = NetworkManager.baseUrl
        var path: String {
            switch self {
            case .getUsers(_):
                return "/users"
            case .getUserDetails(let userName):
                return "/users/\(userName)"
            case .getRepositories(let userName, _):
                return "/users/\(userName)/repos"
            }
        }
        var completeUrlString = "\(baseUrl)\(path)"
        if let queryParams {
            completeUrlString = completeUrlString + "?\(queryParams)"
        }
        return completeUrlString
    }
    
    // it is repeating, but I think this is easier to maintain :)
    var httpMethod: HTTPMethod {
        switch self {
        case .getUsers:         return .get
        case .getUserDetails:   return .get
        case .getRepositories:  return .get
        }
    }
}
