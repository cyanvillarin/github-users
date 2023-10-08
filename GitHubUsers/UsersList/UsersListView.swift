//
//  UsersListView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
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
                if viewModel.users.last?.id == user.id {
                    viewModel.fetchAdditionalUsers()
                }
            }
        }
        .navigationTitle("GitHub Users")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            ForEach(UserDefaultsManager.shared.getSearchUserHistory().reversed(), id: \.self) { suggestion in
                Text(suggestion).searchCompletion(suggestion)
            }
        }
        .onChange(of: searchText) { searchText in
            viewModel.searchText = searchText
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
