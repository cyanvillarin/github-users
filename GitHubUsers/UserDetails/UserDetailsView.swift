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
    
    // for initialization
    private var userName: String
    
    // Seems like this is the workaround since we get this error message:
    // [ Cannot assign to property: 'viewModel' is a get-only property ]
    // when we initialize ViewModel from our init()
    init(userName: String) {
        self.userName = userName
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(userName: userName))
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // views for the header
            if let userDetails = viewModel.userDetails {
                VStack(spacing: 5) {
                    Spacer().frame(height: 10)
                    HeaderTopSection(userDetails: userDetails)
                    Spacer().frame(height: 5)
                    HeaderBottomSection(userDetails: userDetails)
                    Spacer().frame(height: 15)
                }
            }
            
            // repositories list
            // fetch additional repos when the user goes at the bottom of the list
            List {
                Section {
                    ForEach(viewModel.repositories) { repository in
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
                } header: {
                    Text(Localizable.repositoriesListTitle)
                }
            }
            // explicitly set the style to insetGroup to have padding on every sides
            .listStyle(.insetGrouped)
        }
        .toast(isPresenting: $viewModel.shouldShowToastMessage, duration: Constants.toastDisplayDuration) {
            AlertToast(
                displayMode: .banner(.slide),
                type: .error(.red),
                title: Localizable.toastErrorTitle,
                subTitle: viewModel.toastMessage
            )
        }
        .navigationTitle(userName)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userName: "cyanvillarin")
    }
}

