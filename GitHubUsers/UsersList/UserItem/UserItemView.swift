//
//  UserItemView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Kingfisher

struct UserItemView: View {
    
    var userName: String
    var userType: String
    var avatarUrlString: String
    
    init(avatarUrlString: String, userName: String, userType: String) {
        self.avatarUrlString = avatarUrlString
        self.userName = userName
        self.userType = userType
    }
    
    // Reference for the .startLoadingBeforeViewAppear() solution
    // https://github.com/onevcat/Kingfisher/issues/1988#issuecomment-1368591127
    var body: some View {
        NavigationLink(destination: UserDetailsView(userName: userName)) {
            HStack(spacing: 10) {
                avatarView()
                    .resizable()
                    .startLoadingBeforeViewAppear()  // solution for messy List + KF issue if there is .frame modifier user
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                    .onAppear()
                
                VStack(spacing: 3) {
                    HStack {
                        Text(userName)
                        Spacer()
                    }
                    HStack {
                        Text(userType).font(.caption).opacity(0.5)
                        Spacer()
                    }
                }
                
            }
        }
    }
    
    func avatarView() -> KFImage {
        
        let url = URL(string: avatarUrlString)
        
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

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(
            avatarUrlString: "https://error-image.com",
            userName: "Cyan Villarin",
            userType: "User"
        )
    }
}
