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
    
    var body: some View {
        List(viewModel.users) { user in
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
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
