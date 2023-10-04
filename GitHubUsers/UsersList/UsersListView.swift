//
//  UsersListView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/04.
//

import SwiftUI
import Combine

struct UsersListView: View {
    var body: some View {
        List {
            UserItemView(userName: "Cyan Villarin", image: "test")
            UserItemView(userName: "Miho Villarin", image: "test")
            UserItemView(userName: "Some Test", image: "test")
            UserItemView(userName: "Kousuke Fujita", image: "test")
            UserItemView(userName: "Cray Villarin", image: "test")
            UserItemView(userName: "Eisuke Fujita", image: "test")
            UserItemView(userName: "Hello Man", image: "test")
        }
        .navigationTitle("GitHub Users")
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
