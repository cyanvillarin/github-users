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
    
    func testFetchUsersSuccess() async {
        let mockUsers = [
            User(id: 1, userName: "User1", avatarUrl: "", type: ""),
            User(id: 2, userName: "User2", avatarUrl: "", type: "")
        ]
        let mockResult: Any = mockUsers
        mockNetworkManager.mockResultElement = mockResult
        
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.allUsers, mockUsers)
        XCTAssertEqual(viewModel.usersToDisplay, mockUsers)
        XCTAssertFalse(viewModel.shouldShowToastMessage)
        XCTAssertNil(viewModel.toastMessage)
    }
    
    func testFetchUsersFailure() async {
        let mockError = AFError.explicitlyCancelled
        mockNetworkManager.mockResultAFError = mockError
        
        await viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.shouldShowToastMessage)
        XCTAssertEqual(viewModel.toastMessage, mockError.localizedDescription)
    }
}
