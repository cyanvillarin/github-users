//
//  MainView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/04.
//

import SwiftUI

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
