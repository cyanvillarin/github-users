//
//  UserDetailsViewModel.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/05.
//

import Combine
import Alamofire

class UserDetailsViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails? = nil
    @Published var repositories: [Repository] = []
    
    private var cancellable = Set<AnyCancellable>()
        
    var userName: String
    
    var reposCount: Int = 0
    
    init(userName: String) {
        self.userName = userName
        fetchUserDetails()
        fetchRepositories()
    }
    
    private func fetchUserDetails() {
        
        // TODO: Refactor this into like a global variable
        guard let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = "https://api.github.com/users/\(userName)"
        
        AF.request(urlString, method: .get, headers: headers)
            .publishDecodable(type: UserDetails.self)
            .receive(on: DispatchQueue.main)    // set the scheduler
            .sink { [weak self] response in     // same as onNext
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    self.userDetails = response
                case .failure:
                    self.userDetails = nil
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
    private func fetchRepositories() {
        
        // TODO: Refactor this into like a global variable
        guard let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = "https://api.github.com/users/\(userName)/repos"
        
        AF.request(urlString, method: .get, headers: headers)
            .publishDecodable(type: [Repository].self)
            .receive(on: DispatchQueue.main)    // set the scheduler
            .print("users api response")        // same as debug
            .sink { [weak self] response in     // same as onNext
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    let repos = response
                    self.repositories = repos
                    if let publicReposCount = self.userDetails?.publicReposCount {
                        self.reposCount = publicReposCount - self.repositories.filter { $0.isFork }.count   // only display the non-forked repos' count
                    } 
                    
                case .failure:
                    self.repositories = []
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
}
