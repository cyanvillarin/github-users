//
//  User.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/05.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int64           // use the id for 'id' for Identifiable
    let userName: String
    let url: String
    let avatarUrl: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case url
        case avatarUrl = "avatar_url"
        case type
    }
}
