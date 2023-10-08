//
//  User.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/08.
//

import Foundation

struct User: Decodable, Identifiable {
    
    // for Identifiable
    let id: Int64
    
    // for User
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
