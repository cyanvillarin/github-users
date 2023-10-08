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
    
    
    @Published var usersToDisplay: [User] = []  // observed by the View to know which items to display (filtered when using the searchBar)
    
    var users: [User] = [] // this contains all the users to be displayed on View
    
    private var lastId: Int64 = 0 // this is the id to be used from 'since' - for pagination
    
    private var cancellable = Set<AnyCancellable>()  // same as DisposeBag
        
    let urlString = "https://api.github.com/users"
    
    @Published var searchText = ""
    
    init() {
        fetchUsers()
        bindData()
    }
    
    private func bindData() {
        $searchText
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] searchText in
                guard let self else { return }
                self.searchUser(withUserName: searchText)
            })
            .store(in: &cancellable)
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
                    self.usersToDisplay = response
                    if let lastId = response.last?.id {
                        self.lastId = lastId
                    }
                case .failure:
                    self.users = []
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
    func searchUser(withUserName searchText: String) {
        
        // if 'searchText' becomes empty string, return the 'users'
        if searchText == "" {
            usersToDisplay = users
        }
        
        // when searching, first see if the user is already in the list
        if let resultUser = users.first(where: { $0.userName == searchText }) {
            usersToDisplay = [resultUser]
            return
        }
        
        // if the user is not on the list, search for it
        guard let accessToken = ProcessInfo.processInfo.environment["ACCESS_TOKEN"] else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        let urlString = "https://api.github.com/users/\(searchText)"
        
        AF.request(urlString, method: .get, headers: headers)
            .publishDecodable(type: UserDetails.self)
            .receive(on: DispatchQueue.main)    // set the scheduler
            .sink { [weak self] response in     // same as onNext
                guard let self else { return }
                switch response.result {
                case .success(let response):
                    let user = User(
                        id: response.id,
                        userName: response.userName,
                        avatarUrl: response.avatarUrl,
                        type: response.type
                    )
                    self.usersToDisplay = [user]
                    UserDefaultsManager.addToSearchedUsers(item: searchText)

                case .failure: return
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
                    self.usersToDisplay = usersCopy
                    print("last user id: \(self.lastId)")
                case .failure:
                    return
                }
            }
            .store(in: &cancellable)    // same as disposedBy
    }
    
}
