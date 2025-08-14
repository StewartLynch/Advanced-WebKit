//
//----------------------------------------------
// Original project: Advanced WebKit
// by  Stewart Lynch on 2025-08-13
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

// https://youtu.be/qk2y-TiLDZo?si=l-FInVRCKpg0c3fL

import SwiftUI
import WebKit

struct WebViewFromHtmlWithConfig: View {
//    @State private var page = WebPage()
    @State private var page: WebPage = {
        var config = WebPage.Configuration()
        config.mediaPlaybackBehavior = .allowsInlinePlayback
        return WebPage(configuration: config)
    }()
    let html = """
        <iframe width="900" height="506" src="https://www.youtube.com/embed/qk2y-TiLDZo?si=02yqyWvxnB6MElaM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        """
    var body: some View {
        NavigationStack {
            VStack() {
                WebView(page)
            }
            .navigationTitle("Page Title")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
//            page.load(html: html)
            do {
                let htmlContent = try BundleManager.loadHTML(named: "Sample")
                page.load(html: htmlContent)
            } catch {
                
            }
        }
    }
}

#Preview {
    WebViewFromHtmlWithConfig()
}

