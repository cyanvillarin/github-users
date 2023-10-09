//
//  RepositoryDetailsView.swift
//  GitHubUsers
//
//  Created by Cyan Villarin on 2023/10/05.
//

import SwiftUI

struct RepositoryDetailsView: View {
    
    @State private var isLoading = true
    @State private var error: Error? = nil
    let url: URL?
    
    // loads a webview that is the same height as the screen
    // displays error message if it fails
    // displays a progress view while it is still loading the web view
    var body: some View {
        ZStack {
            if let error = error {
                Text(error.localizedDescription).foregroundColor(.pink)
            } else {
                if let url = url {
                    GeometryReader { geometry in
                        ScrollView {
                            WebView(url: url, isLoading: $isLoading, error: $error)
                                .frame(height: geometry.size.height)
                        }
                    }
                    if isLoading { ProgressView() }
                } else {
                    Text(Localizable.repositoryErrorMessage).foregroundColor(.pink)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(url: URL(string: "https://www.swiftyplace.com")!)
    }
}
