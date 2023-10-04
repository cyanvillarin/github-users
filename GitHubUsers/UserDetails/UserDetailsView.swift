//
//  UserDetailsView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Combine

struct UserDetailsView: View {
    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text("cyanvillarin")
            Text("Cyan Villarin")
            Text("Followers: 232")
            Text("Follows: 250")
            
            List {
                RepositoryItemView(
                    repositoryName: "GitHubUsers",
                    devLanguage: "Swift",
                    numberOfStars: "23",
                    description: "This is something"
                )
                RepositoryItemView(
                    repositoryName: "ChatZone",
                    devLanguage: "Swift",
                    numberOfStars: "62",
                    description: "This is a chat app"
                )
                RepositoryItemView(
                    repositoryName: "Facebook",
                    devLanguage: "Swift",
                    numberOfStars: "151",
                    description: "This is an app"
                )
                RepositoryItemView(
                    repositoryName: "TestingApp",
                    devLanguage: "Swift",
                    numberOfStars: "2",
                    description: "A test app"
                )
                RepositoryItemView(
                    repositoryName: "Help",
                    devLanguage: "Ruby",
                    numberOfStars: "232",
                    description: "This is a web app"
                )
                RepositoryItemView(
                    repositoryName: "Help",
                    devLanguage: "Ruby",
                    numberOfStars: "232",
                    description: "This is a web app"
                )
                RepositoryItemView(
                    repositoryName: "Help",
                    devLanguage: "Ruby",
                    numberOfStars: "232",
                    description: "This is a web app"
                )
            }
        }
        .navigationTitle("cyanvillarin")
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}

