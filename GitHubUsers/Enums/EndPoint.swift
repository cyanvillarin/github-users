//
//  EndPoint.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/08.
//

import Alamofire

enum EndPoint {
    case getUsers(lastUserId: Int64)    // lastUserId refers to the id where the list will start
    case getUserDetails(userName: String)
    case getRepositories(userName: String, currentPage: Int)
    
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
    
    // it is repeating, but I kinda like how this looks :)
    var httpMethod: HTTPMethod {
        switch self {
        case .getUsers:         return .get
        case .getUserDetails:   return .get
        case .getRepositories:  return .get
        }
    }
    
    var queryParams: String? {
        switch self {
        case .getUsers(let lastUserId):
            return "since=\(lastUserId)"
        case .getUserDetails:
            return "per_page=\(NetworkManager.usersPageLimit)"
        case .getRepositories(_ , let currentPage):
            return "per_page=\(NetworkManager.reposPageLimit)&page=\(currentPage)"
        }
    }
}
