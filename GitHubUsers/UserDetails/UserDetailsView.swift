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
        
        VStack(spacing: 5) {
            
            // upper
            HStack(spacing: 15) {
                avatarView(viewModel.userDetails?.avatarUrl ?? "")  // TODO: improve this part
                    .resizable()
                    .startLoadingBeforeViewAppear()  // solution for messy List + KF issue if there is .frame modifier user
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .clipShape(Circle())
                    .onAppear()
                
                Spacer().frame(width: 5)
                
                VStack {
                    Text("\(viewModel.repositories.count)").bold()
                    Text("Repos")
                }
                
                VStack {
                    Text("\(viewModel.userDetails?.followers ?? 0)").bold()
                    Text("Followers")
                }
                
                VStack {
                    Text("\(viewModel.userDetails?.following ?? 0)").bold()
                    Text("Following")
                }
            }
            
            Spacer().frame(height: 5)
            
            // lower
            if let fullName = viewModel.userDetails?.fullName {
                HStack {
                    Text(fullName).bold()
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
            
            if let bio = viewModel.userDetails?.bio {
                HStack {
                    Text(bio)
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
            
            if let company = viewModel.userDetails?.company {
                HStack {
                    Text(company)
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
            
            Spacer().frame(height: 5)
            
            // repo list
            List(viewModel.repositories) { repository in
                RepositoryItemView(
                    url: repository.url,
                    name: repository.name,
                    numberOfStars: repository.stars,
                    devLanguage: repository.language,
                    description: repository.description
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

