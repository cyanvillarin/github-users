//
//  UsersListViewModel.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import Combine
import Alamofire

// TODO: Implement Pagination

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []  // same as BehaviorRelay since there is initial value
    
    var lastId: Int64 = 0 // this is the id to be used from 'since' - for pagination
    
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
                    if let lastId = response.last?.id {
                        self.lastId = lastId
                    }
                    print("last user id: \(self.lastId)")
                case .failure:
                    self.users = []
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
    func fetchAdditionalUsers() {
        print("fetching additional users from user id: \(lastId)")
        
        guard let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let urlWithSince = "\(urlString)?since=\(self.lastId)"
        
        AF.request(urlWithSince, method: .get, headers: headers)
            .publishDecodable(type: [User].self)
            .receive(on: DispatchQueue.main)    // set the scheduler
            .print("users api response")        // same as debug
            .sink { [weak self] response in     // same as onNext
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    
                    if let lastId = response.last?.id {
                        self.lastId = lastId
                    }
                    
                    var usersCopy = self.users
                    usersCopy.append(contentsOf: response)
                    self.users = usersCopy
                    print("last user id: \(self.lastId)")
                case .failure:
                    print("Something bad happened")
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
}
