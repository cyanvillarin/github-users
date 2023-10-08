//
//  UsersListViewModel.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import Combine
import Alamofire

class UsersListViewModel: ObservableObject {
    
    // set from the view when user types in the search bar
    @Published var searchText = ""
    
    // observed by the View to know which items to display (filtered when using the searchBar)
    @Published var usersToDisplay: [User] = []
    
    // observed by the View to know if we need to show toast message
    @Published var shouldShowToastMessage = false
    @Published var toastMessage: String? = nil
    
    // this contains all the users to be displayed on View
    var allUsers: [User] = []
    
    // this is the id to be used from 'since' - for pagination
    private var lastUserId: Int64 = 0
    
    // same as DisposeBag
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        bindData()
        Task { await fetchUsers() }
    }
    
    private func bindData() {
        $searchText
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] searchText in
                guard let self else { return }
                Task { await self.searchUser(withUserName: searchText) }
            })
            .store(in: &cancellable)
    }
    
    @MainActor private func fetchUsers() async {
        let endpoint = EndPoint.getUsers(lastUserId: 0)
        let result: Result<[User], AFError> = await NetworkManager.shared.sendRequest(endpoint: endpoint)
        switch result {
        case .success(let users):
            self.allUsers = users
            self.usersToDisplay = users
            if let lastId = users.last?.id {
                self.lastUserId = lastId
            }
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
    
    @MainActor private func searchUser(withUserName searchText: String) async {
        // if 'searchText' is an empty string, display 'allUsers'
        if searchText == "" {
            usersToDisplay = allUsers
            return
        }
        
        // add the searched text into the UserDefaults
        UserDefaultsManager.shared.addToSearchUserHistory(searchText)
        
        // check first if the 'searchText' user is already on the 'allUsers' list
        if let resultUser = allUsers.first(where: { $0.userName == searchText }) {
            usersToDisplay = [resultUser]
            return
        }
        
        // if the user is not on the list, search for it
        let endpoint = EndPoint.getUserDetails(userName: searchText)
        let result: Result<UserDetails, AFError> = await NetworkManager.shared.sendRequest(endpoint: endpoint)
        print(result)
        switch result {
        case .success(let userDetails):
            // in order to display, need to convert this into User
            let user = User(
                id: userDetails.id,
                userName: userDetails.userName,
                avatarUrl: userDetails.avatarUrl,
                type: userDetails.type
            )
            self.usersToDisplay = [user]
            
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
    
    @MainActor func fetchAdditionalUsers() async {
        let endpoint = EndPoint.getUsers(lastUserId: self.lastUserId)
        let result: Result<[User], AFError> = await NetworkManager.shared.sendRequest(endpoint: endpoint)
        switch result {
        case .success(let users):
            if let lastId = users.last?.id {
                self.lastUserId = lastId
            }
            var usersCopy = self.allUsers
            usersCopy.append(contentsOf: users)
            self.allUsers = usersCopy
            self.usersToDisplay = usersCopy
            
        case .failure(let error):
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
}
