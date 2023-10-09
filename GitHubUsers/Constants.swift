//
//  Constants.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/09.
//

import Foundation

struct Constants {
    
    // api related
    static let baseUrl = "https://api.github.com"
    
    // page limits
    static let usersPageLimit = 30
    static let reposPageLimit = 30
    
    // user defaults keys
    static let searchedUsersKey = "searchedUsers"
    
    // images
    static let defaultUserLogo = "DefaultUserLogo"
    
    // toast related
    static let toastDisplayDuration: Double = 5
    
}
