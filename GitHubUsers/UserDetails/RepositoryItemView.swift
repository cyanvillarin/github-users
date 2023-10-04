//
//  RepositoryItemView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI

struct RepositoryItemView: View {
    
    var repositoryName: String
    var devLanguage: String
    var numberOfStars: String
    var description: String
    
    init(repositoryName: String, devLanguage: String, numberOfStars: String, description: String) {
        self.repositoryName = repositoryName
        self.devLanguage = devLanguage
        self.numberOfStars = numberOfStars
        self.description = description
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(repositoryName)
                Text(devLanguage)
                Text(numberOfStars)
            }
            
            Text(description)
        }
    }
}

struct RepositoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItemView(repositoryName: "GitHubUsers", devLanguage: "Swift", numberOfStars: "23", description: "This is a project for seeing users")
    }
}
