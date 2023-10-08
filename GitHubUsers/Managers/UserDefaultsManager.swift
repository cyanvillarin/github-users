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
    
    // keys
    static let searchedUsersKey = "searchedUsers"
    
    // just return empty List if it is not yet saved
    private func getSearchedUsers() -> [String] {
        let searchedUsers = UserDefaults.standard.array(forKey: UserDefaultsManager.searchedUsersKey) as? [String]
        return searchedUsers ?? []
    }
    
    // reverse it so that the most recent is at the top
    func getSearchUserHistory() -> [String] {
        return getSearchedUsers().reversed()
    }
    
    // first, get the searchedUsers, then removed it if it's already saved
    // then append, so that it would appear at the top of the list (most recent at the top)
    func addToSearchUserHistory(_ item: String) {
        var searchedUsers = getSearchedUsers()
        if searchedUsers.contains(item) {
            searchedUsers.removeAll(where: { $0 == item })
        }
        searchedUsers.append(item)
        UserDefaults.standard.set(searchedUsers, forKey: UserDefaultsManager.searchedUsersKey)
    }
}
