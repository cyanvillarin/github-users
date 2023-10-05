//
//  UserDetailsView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Combine
import Kingfisher

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    
    var userName: String
    
    // Seems like this is the workaround since we get this error message when we initialize ViewModel from our init()
    // Cannot assign to property: 'viewModel' is a get-only property
    init(userName: String) {
        self.userName = userName
        _viewModel = StateObject(wrappedValue: UserDetailsViewModel(userName: userName))
    }
    
    var body: some View {
        VStack {
            avatarView(viewModel.userDetails?.avatarUrl ?? "")  // TODO: improve this part
                .resizable()
                .startLoadingBeforeViewAppear()  // solution for messy List + KF issue if there is .frame modifier user
                .frame(width: 80, height: 80)
                .scaledToFit()
                .clipShape(Circle())
                .onAppear()
            
            Text("\(viewModel.userDetails?.fullName ?? "")")                // TODO: improve this part
            Text("Followers: \(viewModel.userDetails?.followers ?? 0)")     // TODO: improve this part
            Text("Following: \(viewModel.userDetails?.following ?? 0)")     // TODO: improve this part
            
            List(viewModel.repositories) { repository in
                RepositoryItemView(
                    url: repository.url,
                    name: repository.name,
                    devLanguage: repository.language ?? "",
                    numberOfStars: repository.stars,
                    description: repository.description ?? ""
                )
            }
        }
        .navigationTitle(userName)
    }
    
    // TODO: make this a common function
    func avatarView(_ urlString: String) -> KFImage {
        
        let url = URL(string: urlString)
        
        let defaultImage = Image("default_user_logo")
            .resizable()
            .frame(width: 50, height: 50)
        
        let image = KFImage(url)
            .placeholder { defaultImage }
            .retry(maxCount: 3, interval: .seconds(5))
            .cacheOriginalImage()
        
        return image
    }
    
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userName: "cyanvillarin")
    }
}

