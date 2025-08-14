//
//----------------------------------------------
// Original project: Advanced WebKit
// by  Stewart Lynch on 2025-08-14
//
// Follow me on Mastodon: https://iosdev.space/@StewartLynch
// Follow me on Threads: https://www.threads.net/@stewartlynch
// Follow me on Bluesky: https://bsky.app/profile/stewartlynch.bsky.social
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Email: slynch@createchsol.com
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2025 CreaTECH Solutions. All rights reserved.

import SwiftUI
import WebKit

struct BasicWebViewFromPageWithRequest: View {
    @State private var page = WebPage()
    var body: some View {
        NavigationStack {
            VStack() {
                if page.isLoading {
                    ProgressView(value: page.estimatedProgress)
                        .progressViewStyle(.linear)
                        .transition(.opacity)
                        .padding()
                } else {
                    Text(" ")
                        .padding(.vertical, -10)
                }
                WebView(page)
                    .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle(page.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            let url = URL(string: "https://www.swift.org")
            var request = URLRequest(url: url!)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            page.load(request)
//            page.load(url)
        }
    }
}

#Preview {
    BasicWebViewFromPageWithRequest()
}
