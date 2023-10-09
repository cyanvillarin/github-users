//
//  UsersListView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import SwiftUI
import Combine

struct UsersListView: View {
    
    @StateObject var viewModel = UsersListViewModel(networkManager: NetworkManager())
    @State private var searchText = String.emptyString
    
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
        .navigationTitle(Localizable.usersListTitle)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
            ForEach(UserDefaultsManager.shared.getSearchUserHistory(), id: \.self) { suggestion in
                Text(suggestion).searchCompletion(suggestion)
            }
        }
        .onChange(of: searchText) { searchText in
            viewModel.searchText = searchText
        }
        .toast(isPresenting: $viewModel.shouldShowToastMessage, duration: Constants.toastDisplayDuration) {
            AlertToast(
                displayMode: .banner(.slide),
                type: .error(.red),
                title: Localizable.toastErrorTitle,
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
