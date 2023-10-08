//
//  HeaderTopSection.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/09.
//

import SwiftUI
import Kingfisher

extension UserDetailsView {
    struct HeaderTopSection: View {
        var userDetails: UserDetails
        init(userDetails: UserDetails) {
            self.userDetails = userDetails
        }
        var body: some View {
            HStack(spacing: 15) {
                avatarView(userDetails.avatarUrl)
                    .resizable()
                    .startLoadingBeforeViewAppear()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .clipShape(Circle())
                    .onAppear()
                
                Spacer().frame(width: 1)
                
                VStack {
                    Text("\(userDetails.followers)").bold()
                    Text("Followers")
                }
                
                VStack {
                    Text("\(userDetails.following)").bold()
                    Text("Following")
                }
            }
        }
        
        func avatarView(_ urlString: String) -> KFImage {
            let url = URL(string: urlString)
            let defaultImage = Image("DefaultUserLogo")
                .resizable()
                .frame(width: 50, height: 50)
            let image = KFImage(url)
                .placeholder { defaultImage }
                .retry(maxCount: 3, interval: .seconds(5))
                .cacheOriginalImage()
            return image
        }
    }

    struct HeaderTopSection_Previews: PreviewProvider {
        static var previews: some View {
            HeaderTopSection(
                userDetails: UserDetails(
                    id: 1,
                    userName: "cyanvillarin",
                    avatarUrl: "test.com",
                    type: "User",
                    fullName: "Cyan Villarin",
                    bio: "Hello world!",
                    company: "UniFa",
                    followers: 1,
                    following: 3
                )
            )
        }
    }
}

