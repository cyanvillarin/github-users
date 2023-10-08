//
//  UserDetailsView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import SwiftUI
import Combine

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    
    var userName: String
    
    // Seems like this is the workaround since we get this error message:
    // [ Cannot assign to property: 'viewModel' is a get-only property ]
    // when we initialize ViewModel from our init()
    init(userName: String) {
        self.userName = userName
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(userName: userName))
    }
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            // header
            if let userDetails = viewModel.userDetails {
                HeaderTopSection(userDetails: userDetails)
                Spacer().frame(height: 5)
                HeaderBottomSection(userDetails: userDetails)
                Spacer().frame(height: 5)
            }
            
            // repo list
            List(viewModel.repositories) { repository in
                RepositoryItemView(
                    url: repository.url,
                    name: repository.name,
                    numberOfStars: repository.stars,
                    devLanguage: repository.language,
                    description: repository.description
                )
                .onAppear() {
                    // when the user goes to the bottom of the list, fetch new repos
                    if viewModel.repositories.last?.id == repository.id {
                        Task { await viewModel.fetchRepositories() }
                    }
                }
            }
            
        }
        .navigationTitle(userName)
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

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userName: "cyanvillarin")
    }
}

