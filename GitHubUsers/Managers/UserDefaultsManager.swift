//
//  UserDefaultsManager.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/08.
//

import Foundation

class UserDefaultsManager {
    
    static func getSearchedUsers() -> [String] {
        let userDefaults = UserDefaults.standard
        let searchedUsers = userDefaults.array(forKey: "searchedUsers") as? [String]
        return searchedUsers ?? []
    }
    
    static func addToSearchedUsers(item: String) {
        let userDefaults = UserDefaults.standard
        var searchedUsers = userDefaults.array(forKey: "searchedUsers") as? [String] ?? []
        searchedUsers.append(item)
        userDefaults.set(searchedUsers, forKey: "searchedUsers")
    }
}
