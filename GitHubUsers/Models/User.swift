//
//  User.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/08.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int64 // use the id for 'id' for Identifiable
    let userName: String
    let avatarUrl: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarUrl = "avatar_url"
        case type
    }
}
