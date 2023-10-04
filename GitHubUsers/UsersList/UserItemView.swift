//
//  UserItemView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI

struct UserItemView: View {
    
    var userName: String
    
    init(userName: String, image: String) {
        self.userName = userName
    }
    
    var body: some View {
        NavigationLink(destination: UserDetailsView()) {
            HStack(spacing: 10) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(userName)
            }
        }
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(userName: "Cyan Villarin", image: "test")
    }
}
