//
//  MainView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI

/*
 TODO:
    1. Add the reason for iOS 15 for the 'searchable' function
    2. Add instructions on the README (and explain that the accessToken is deleted on Github when the token is committed).
        Mention that I will send the accessToken through email.
        Also include step-by-step screenshots for setting on the Xcode's environment
    3. Code Refactoring
       a. API
       b. Views
    4. Add Unit Tests
    5. Add Localization
    6. Create demo videos
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
