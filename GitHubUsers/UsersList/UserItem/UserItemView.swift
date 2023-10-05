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
    var avatarUrlString: String
    
    init(userName: String, avatarUrlString: String) {
        self.userName = userName
        self.avatarUrlString = avatarUrlString
    }
    
    var body: some View {
        NavigationLink(destination: UserDetailsView()) {
            HStack(spacing: 10) {
                avatarView()
                    .resizable()
                    .startLoadingBeforeViewAppear()  // solution for messy List + KF issue if there is .frame modifier user
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                    .onAppear()
                Text(userName)
            }
        }
    }
    
    // Reference for the .startLoadingBeforeViewAppear() solution
    // https://github.com/onevcat/Kingfisher/issues/1988#issuecomment-1368591127
    
    func avatarView() -> KFImage {
        
        let url = URL(string: avatarUrlString)
        
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

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(userName: "Cyan Villarin", avatarUrlString: "https://error-image.com")
    }
}
