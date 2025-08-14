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

struct WebViewFromHtmlWithConfig: View {
    var body: some View {
        NavigationStack {
            VStack() {
                Text("WebView From HTML with Config")
            }
            .navigationTitle("Page Title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    WebViewFromHtmlWithConfig()
}

