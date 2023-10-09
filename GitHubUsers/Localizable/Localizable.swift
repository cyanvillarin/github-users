//
//  Localizable.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/09.
//

import Foundation

// NOTE: I thought that the comment is not needed since it could be known from the name itself :)
struct Localizable {
    
    // Common
    static let toastErrorTitle = NSLocalizedString("ToastErrorTitle", comment: "")
    
    // Users List
    static let usersListTitle = NSLocalizedString("UserListTitle", comment: "")
    
    // User Details
    static let followers = NSLocalizedString("Followers", comment: "")
    static let following = NSLocalizedString("Following", comment: "")
    static let repositoriesListTitle = NSLocalizedString("RepositoriesListTitle", comment: "")

    // Repository Web View
    static let repositoryErrorMessage = NSLocalizedString("RepositoryErrorMessage", comment: "")
}
