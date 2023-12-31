//
//  UsersListViewModel.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import Combine
import Alamofire

class UsersListViewModel: ObservableObject {
    
    // set from the view when user types in the search bar
    @Published var searchText = String.emptyString
    
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
    
    // for initialization
    private var networkManager: NetworkManagerProtocol
    
    /// binds searchText
    /// as well as fetches the initial users for the list
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.bindData()
        Task { await fetchUsers() }
    }
    
    /// binds searchText to search for user when user types in the search bar
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
    
    /// initial fetch for the users, so the lastUserId for the 'since' query parameter is 0
    /// updates the retrieved users list's last user ID as the lastUserId for 'since' the next time fetchAdditionalUsers is called
    @MainActor func fetchUsers() async {
        let endpoint = EndPoint.getUsers(lastUserId: 0)
        let result: Result<[User], AFError> = await networkManager.sendRequest(endpoint: endpoint)
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
    
    /// searches for a user using the userDetails API
    /// - Parameter searchText: the username to be used for userDetails API
    @MainActor func searchUser(withUserName searchText: String) async {
        // if 'searchText' is an empty string, display 'allUsers'
        if searchText == String.emptyString {
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
        let result: Result<UserDetails, AFError> = await networkManager.sendRequest(endpoint: endpoint)
        
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
            // in case something fails, set a value to the publisher for showing toast
            self.toastMessage = error.localizedDescription
            self.shouldShowToastMessage = true
        }
    }
    
    /// a bit different from fetchUsers as after the response is retrieved, it is appended to the allUsers list
    @MainActor func fetchAdditionalUsers() async {
        let endpoint = EndPoint.getUsers(lastUserId: self.lastUserId)
        let result: Result<[User], AFError> = await networkManager.sendRequest(endpoint: endpoint)
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
