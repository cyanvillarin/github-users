//
//  HeaderBottomSection.swift
//  GitHubUsers
//
//  Created by CYAN on 2023/10/09.
//

import SwiftUI

extension UserDetailsView {
    struct HeaderBottomSection: View {
        var userDetails: UserDetails
        init(userDetails: UserDetails) {
            self.userDetails = userDetails
        }
        var body: some View {
            if let fullName = userDetails.fullName {
                HStack {
                    Text(fullName).bold()
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
            
            if let bio = userDetails.bio {
                HStack {
                    Text(bio)
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
            
            if let company = userDetails.company {
                HStack {
                    Text(company)
                    Spacer()
                }
                .padding(.leading, 33)
                .padding(.trailing, 20)
            }
        }
    }
    
    struct HeaderBottomSection_Previews: PreviewProvider {
        static var previews: some View {
            HeaderBottomSection(
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
