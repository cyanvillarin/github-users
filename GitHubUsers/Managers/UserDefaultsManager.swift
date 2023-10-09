//
//  UserDefaultsManager.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/08.
//

import Foundation

class UserDefaultsManager {

    // singleton because this will be used all through-out the project
    static let shared = UserDefaultsManager()
    
    /// a private function to be used to get the saved users
    /// just return empty List if it is not yet saved
    /// - Returns: the saved users
    private func getSearchedUsers() -> [String] {
        let searchedUsers = UserDefaults.standard.array(forKey: Constants.searchedUsersKey) as? [String]
        return searchedUsers ?? []
    }
    
    /// a method we can use for getting the saved users
    /// reverse it so that the most recent is at the top
    /// - Returns: the saved users in reverse
    func getSearchUserHistory() -> [String] {
        return getSearchedUsers().reversed()
    }
    
    /// first, get the searchedUsers, then removed it if it's already saved
    /// then append, so that it would appear at the top of the list (most recent at the top)
    /// - Parameter item: the user we want to search
    func addToSearchUserHistory(_ item: String) {
        var searchedUsers = getSearchedUsers()
        if searchedUsers.contains(item) {
            searchedUsers.removeAll(where: { $0 == item })
        }
        searchedUsers.append(item)
        UserDefaults.standard.set(searchedUsers, forKey: Constants.searchedUsersKey)
    }
}
