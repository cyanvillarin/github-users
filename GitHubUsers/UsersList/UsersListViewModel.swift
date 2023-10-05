//
//  UsersListViewModel.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import Combine
import Alamofire

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []  // same as BehaviorRelay since there is initial value
    
    private var cancellable = Set<AnyCancellable>()  // same as DisposeBag
        
    let urlString = "https://api.github.com/users"
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        
        // TODO: Add instructions on the README (and explain that the accessToken is deleted on Github when the token is committed)
        // Mention that I will send the accessToken through email, and set the step-by-step screenshots for setting on the Xcode's environment
        guard let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        AF.request(urlString, method: .get, headers: headers)
            .publishDecodable(type: [User].self)
            .receive(on: DispatchQueue.main)    // set the scheduler
            .print("users api response")        // same as debug
            .sink { [weak self] response in     // same as onNext
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    self.users = response
                case .failure:
                    self.users = []
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
}
