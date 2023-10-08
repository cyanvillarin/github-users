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
    
    // same as DisposeBag
    private var cancellable = Set<AnyCancellable>()
    
    // updated when the user successfully display the repo
    private var currentPage = 1
    
    var userName: String
    init(userName: String) {
        self.userName = userName
        Task {
            await fetchUserDetails()
            await fetchRepositories()
        }
    }
    
    @MainActor private func fetchUserDetails() async {
        let endpoint = EndPoint.getUserDetails(userName: userName)
        let result: Result<UserDetails, AFError> = await NetworkManager.shared.sendRequest(endpoint: endpoint)
        switch result {
        case .success(let userDetails):
            self.userDetails = userDetails
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
    
    @MainActor func fetchRepositories() async {
        let endpoint = EndPoint.getRepositories(userName: userName, currentPage: currentPage)
        let result: Result<[Repository], AFError> = await NetworkManager.shared.sendRequest(endpoint: endpoint)
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
