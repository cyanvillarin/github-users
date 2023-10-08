//
//  Repository.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/05.
//

import Foundation

struct Repository: Decodable, Identifiable {
    
    // for Identifiable
    let id: Int64
    let name: String
    let url: String
    let language: String?
    let stars: Int
    let description: String?
    let isFork: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
        case language
        case stars = "stargazers_count"
        case description
        case isFork = "fork"
    }
}
