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
    
    let apiToken = "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"
    
    let urlString = "https://api.github.com/users"
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(apiToken)"]
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
