//
//  RepositoryItemView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI

struct RepositoryItemView: View {
    
    var url: String
    var numberOfStars: Int
    var name: String
    var devLanguage: String?
    var description: String?
    
    init(url: String, name: String, numberOfStars: Int, devLanguage: String?, description: String?) {
        self.url = url
        self.name = name
        self.devLanguage = devLanguage
        self.numberOfStars = numberOfStars
        self.description = description
    }
    
    var body: some View {
        NavigationLink(destination: RepositoryDetailsView(url: URL(string: url))) {
            VStack(spacing: 2) {
                
                HStack {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text(String(numberOfStars))
                        .font(.caption)
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                HStack {
                    Text(name)
                        .bold()
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                if let devLanguage {
                    HStack {
                        Text(String(devLanguage))
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                }
                
                if let description {
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
}

struct RepositoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItemView(
            url: "https://google.com",
            name: "GitHubUsers",
            numberOfStars: 23,
            devLanguage: "Swift",
            description: "This is a project for seeing users"
        )
    }
}
