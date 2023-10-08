//
//  UserDetails.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/05.
//

import Foundation

struct UserDetails: Decodable, Identifiable {
    
    // for Identifiable
    let id: Int64
    
    // for UserDetails
    let userName: String
    let avatarUrl: String
    let type: String
    let fullName: String?
    let bio: String?
    let company: String?
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarUrl = "avatar_url"
        case type
        case fullName = "name"
        case bio
        case company
        case followers
        case following
    }
}
