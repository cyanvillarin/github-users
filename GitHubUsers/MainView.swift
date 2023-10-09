//
//  MainView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import SwiftUI

/*
 TODO:
 - Add the reason for iOS 15 for the 'searchable' function
 - Add instructions on the README (and explain that the accessToken is deleted on Github when the token is committed). Mention that I will send the accessToken through email. Also include step-by-step screenshots for setting on the Xcode's environment
 - Create demo videos
*/

struct MainView: View {
    var body: some View {
        NavigationView {
            UsersListView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
