//
//  UsersListViewModelTests.swift
//  GitHubUsersTests
//
//  Created by Cyan Villarin on 2023/10/09.
//

import XCTest
import Alamofire
import Combine

@testable import GitHubUsers

class UsersListViewModelTests: XCTestCase {
    
    var viewModel: UsersListViewModel!
    var mockNetworkManager = MockNetworkManager()
    
    override func setUp() {
        super.setUp()
        viewModel = UsersListViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_fetchUsers_success() async {
        let mockUsers = [
            User(id: 1, userName: "User1", avatarUrl: "", type: ""),
            User(id: 2, userName: "User2", avatarUrl: "", type: "")
        ]
        let mockResult: Any = mockUsers
        mockNetworkManager.mockResultElement = mockResult
        
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.allUsers, mockUsers)
        XCTAssertEqual(viewModel.usersToDisplay, mockUsers)
    }
    
    func test_fetchUsers_failure() async {
        let mockError = AFError.explicitlyCancelled
        mockNetworkManager.mockResultAFError = mockError
        
        await viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.shouldShowToastMessage)
        XCTAssertEqual(viewModel.toastMessage, mockError.localizedDescription)
    }
    
    func test_searchUser() async {
        let mockUserDetails: UserDetails = UserDetails(
            id: 1,
            userName: "User1",
            avatarUrl: "https://profile-pic.com",
            type: "User",
            fullName: "Cyan Villarin",
            bio: "A developer",
            company: "Hello Inc",
            followers: 2,
            following: 5
        )
        mockNetworkManager.mockResultElement = mockUserDetails
        
        await viewModel.searchUser(withUserName: "User1")
    
        let expectedUser = User(
            id: mockUserDetails.id,
            userName: mockUserDetails.userName,
            avatarUrl: mockUserDetails.avatarUrl,
            type: mockUserDetails.type
        )
        
        XCTAssertEqual(viewModel.usersToDisplay, [expectedUser])
    }
}
