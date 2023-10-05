//
//  MainView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Combine

// TODO: Change the minimum from iOS 15 for the AsyncImage function

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
