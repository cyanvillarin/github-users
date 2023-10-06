//
//  RepositoryItemView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI

struct RepositoryItemView: View {
    
    var url: String
    var name: String
    var devLanguage: String
    var numberOfStars: Int
    var description: String
    
    init(url: String, name: String, devLanguage: String, numberOfStars: Int, description: String) {
        self.url = url
        self.name = name
        self.devLanguage = devLanguage
        self.numberOfStars = numberOfStars
        self.description = description
    }
    
    var body: some View {
        NavigationLink(destination: RepositoryDetailsView(url: URL(string: url))) {
            VStack {
                HStack {
                    Text(name)
                        .bold()
                    Spacer()
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text(String(numberOfStars))
                    
                }
                .padding([.leading, .trailing])
                
                HStack {
                    Text(String(devLanguage))
                        .font(.subheadline)
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                HStack {
                    Text(description)
                        .fontWeight(.light)
                        .font(.caption)
                    Spacer()
                }
                .padding([.leading, .trailing])
                
            }
        }
    }
}

struct RepositoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItemView(
            url: "https://google.com",
            name: "GitHubUsers",
            devLanguage: "Swift",
            numberOfStars: 23,
            description: "This is a project for seeing users"
        )
    }
}
