//
//  UserDefaultsManager.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/08.
//

import Foundation

class UserDefaultsManager {

    // singleton because this will be used all through-out the project
    static let shared = UserDefaultsManager()
    
    static let searchedUsersKey = "searchedUsers"
    
    private func getSearchedUsers() -> [String] {
        let searchedUsers = UserDefaults.standard.array(forKey: UserDefaultsManager.searchedUsersKey) as? [String]
        return searchedUsers ?? []
    }
    
    func getSearchUserHistory() -> [String] {
        return getSearchedUsers()
    }
    
    func addToSearchUserHistory(_ item: String) {
        var searchedUsers = getSearchedUsers()
        searchedUsers.append(item)
        UserDefaults.standard.set(searchedUsers, forKey: UserDefaultsManager.searchedUsersKey)
    }
}
