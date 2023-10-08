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
        }
        .navigationTitle("GitHub Users")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            Text("cyanvillarin").searchCompletion("cyanvillarin")
            Text("moneyfoward").searchCompletion("moneyfoward")
            Text("nice one").searchCompletion("nice one")
        }
        .onChange(of: searchText) { searchText in
            viewModel.searchUser(withUserName: searchText)
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
