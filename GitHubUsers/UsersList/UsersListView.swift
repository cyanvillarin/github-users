//
//  UsersListView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import SwiftUI
import Combine

struct UsersListView: View {
    
    @StateObject var viewModel = UsersListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        List(viewModel.usersToDisplay) { user in
            UserItemView(
                avatarUrlString: user.avatarUrl,
                userName: user.userName,
                userType: user.type
            )
            .onAppear() {
                if viewModel.allUsers.last?.id == user.id {
                    Task { await viewModel.fetchAdditionalUsers() }
                }
            }
        }
        .navigationTitle("GitHub Users")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            ForEach(UserDefaultsManager.shared.getSearchUserHistory(), id: \.self) { suggestion in
                Text(suggestion).searchCompletion(suggestion)
            }
        }
        .onChange(of: searchText) { searchText in
            viewModel.searchText = searchText
        }
        .toast(isPresenting: $viewModel.shouldShowToastMessage, duration: 5) {
            AlertToast(
                displayMode: .banner(.slide),
                type: .error(.red),
                title: "An error has occured!",
                subTitle: viewModel.toastMessage
            )
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
