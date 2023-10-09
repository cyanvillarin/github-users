//
//  UserDetailsViewModel.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/05.
//

import Combine
import Alamofire

class UserDetailsViewModel: ObservableObject {
    
    // observed by the View to display info
    @Published var userDetails: UserDetails? = nil
    @Published var repositories: [Repository] = []
    
    // observed by the View to know if we need to show toast message
    @Published var shouldShowToastMessage = false
    @Published var toastMessage: String? = nil
    
    // updated when the user successfully display the repo
    private var currentPage = 1
    
    // for initialization
    private var userName: String
    private var networkManager: NetworkManagerProtocol
    
    /// Initialize then fetch both user details and repositories' list at the same time
    /// - Parameter userName: the parameter used for API calls
    init(userName: String, networkManager: NetworkManagerProtocol) {
        self.userName = userName
        self.networkManager = networkManager
        Task {
            await fetchUserDetails()
            await fetchRepositories()
        }
    }
    
    /// Fetches the user's details for the header's top and bottom sections
    @MainActor func fetchUserDetails() async {
        let endpoint = EndPoint.getUserDetails(userName: userName)
        let result: Result<UserDetails, AFError> = await networkManager.sendRequest(endpoint: endpoint)
        switch result {
        case .success(let userDetails):
            self.userDetails = userDetails
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
    
    /// Fetches the repositories starting with currentPage = 1 then suddenly increasing by 1 everytime
    @MainActor func fetchRepositories() async {
        
        print("I am here AAA")
        
        let endpoint = EndPoint.getRepositories(userName: userName, currentPage: currentPage)
        let result: Result<[Repository], AFError> = await networkManager.sendRequest(endpoint: endpoint)
        
        switch result {    
        case .success(let repositories):
            self.currentPage = self.currentPage + 1
            let filteredRepos = repositories.filter { !$0.isFork }
            var repositoriesCopy = self.repositories
            repositoriesCopy.append(contentsOf: filteredRepos)
            self.repositories = repositoriesCopy
            
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
}
