//
//  RepositoryDetailsView.swift
//  GitHubUsers
//
//  Created by CyanCamit.Villari on 2023/10/05.
//

import SwiftUI

struct RepositoryDetailsView: View {
    
    @State private var isLoading = true
    @State private var error: Error? = nil
    let url: URL?
    
    var body: some View {
        ZStack {
            if let error = error {
                Text(error.localizedDescription)
                                    .foregroundColor(.pink)
            } else {
                if let url = url {
                    GeometryReader { geometry in
                        ScrollView {
                            WebView(url: url, isLoading: $isLoading, error: $error)
                                .frame(height: geometry.size.height)
                        }
                    }
                    if isLoading {
                        ProgressView()
                    }
                } else {
                    Text("Sorry, we couldn't load the URL for this repository.")
                        .foregroundColor(.pink)
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
