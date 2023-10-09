//
//  UserDetailsViewModelTests.swift
//  GitHubUsersTests
//
//  Created by Cyan Villarin on 2023/10/09.
//

import XCTest
import Alamofire
import Combine

@testable import GitHubUsers

class UserDetailsViewModelTests: XCTestCase {
    
    var viewModel: UserDetailsViewModel!
    var mockNetworkManager = MockNetworkManager()
    
    override func setUp() {
        super.setUp()
        viewModel = UserDetailsViewModel(userName: "cyanvillarin", networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_fetchRepositories_success() async {
        let mockRepositories = [
            Repository(id: 1, name: "Repo1", url: "test.com", language: "Swift", stars: 4, description: "", isFork: true),
            Repository(id: 2, name: "Repo2", url: "test.com", language: "Swift", stars: 4, description: "", isFork: true),
            Repository(id: 3, name: "Repo3", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 4, name: "Repo4", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 5, name: "Repo5", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 6, name: "Repo6", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 7, name: "Repo7", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 8, name: "Repo8", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 9, name: "Repo9", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 10, name: "Repo10", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false),
            Repository(id: 11, name: "Repo11", url: "test.com", language: "Swift", stars: 4, description: "", isFork: false)
        ]
        
        let mockResult: Any = mockRepositories
        mockNetworkManager.mockResultElement = mockResult
        mockNetworkManager.mockResultAFError = nil
        
        await viewModel.fetchRepositories()

        XCTAssertEqual(viewModel.repositories, mockRepositories.filter { !$0.isFork })
    }
    
    func test_fetchUsers_failure() async {
        let mockError = AFError.explicitlyCancelled
        mockNetworkManager.mockResultAFError = mockError
        
        await viewModel.fetchRepositories()
        
        XCTAssertTrue(viewModel.shouldShowToastMessage)
        XCTAssertEqual(viewModel.toastMessage, mockError.localizedDescription)
    }
    
    func test_fetchUserDetails() async {
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
        mockNetworkManager.mockResultAFError = nil
        
        await viewModel.fetchUserDetails()
        
        XCTAssertEqual(viewModel.userDetails, mockUserDetails)
    }
}

