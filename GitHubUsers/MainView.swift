//
//  MainView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Combine

// TODO: add the reason for iOS 15 for the 'searchable' function

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
