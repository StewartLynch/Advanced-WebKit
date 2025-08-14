//
//----------------------------------------------
// Original project: Advanced WebKit
// by  Stewart Lynch on 2025-08-09
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

struct StartTab: View {
    @State private var selectedTab = MyTabs.basic
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: .basic) {
                BasicWebViewFromPageWithURL()
            }
            Tab(value: .basicRequest) {
                BasicWebViewFromPageWithRequest()
            }
            Tab(value: .html) {
                WebViewFromHtmlWithConfig()
            }
            Tab(value: .navigation) {
                WebViewFromPageWithNavigation()
            }
            Tab(value: .history) {
                WebViewWithHistory()
            }
            Tab(value: .decision) {
                WebViewWithNavigationDeciding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .safeAreaInset(edge: .top, alignment: .trailing) {
            Menu {
                Picker("Select Tab", selection: $selectedTab) {
                    ForEach(MyTabs.allCases) { tab in
                        Button(tab.title) {
                            selectedTab = tab
                        }
                    }
                }
            } label: {
                Image(systemName: "globe")
                    .font(.title)
                    
            }
            .glassEffect(.regular.interactive())
            .padding()
        }
    }
}

#Preview {
    StartTab()
}

enum MyTabs: Hashable, CaseIterable, Identifiable {
    case basic, basicRequest, html, navigation, history, decision
    var id: Self { self }
    var title: String {
        switch self {
        case .basic:
            "Basic WebView with URL"
        case .basicRequest:
            "WebView with URLRequest"
        case .html:
            "WebView with html and configuration"
        case .navigation:
            "WebView with Navigation"
        case .history:
            "WebView with Navigation History"
        case .decision:
            "Web view with decided navigation"
        }
    }

}
