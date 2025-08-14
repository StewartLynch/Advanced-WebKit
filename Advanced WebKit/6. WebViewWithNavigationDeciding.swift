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

struct WebViewWithNavigationDeciding: View {
    @State private var page = WebPage()
    @State private var disableURL: String?
    var backItems: [WebPage.BackForwardList.Item] {
        page.backForwardList.backList
    }
    var forwardItems: [WebPage.BackForwardList.Item] {
        page.backForwardList.forwardList
    }
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
                    .webViewLinkPreviews(.disabled)
                    .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle(page.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        if let last = backItems.last {
                            page.load(last)
                        }
                    }label: {
                        Image(systemName: "chevron.backward")
                    }
                    .disabled(backItems.isEmpty)
                    Button {
                        if let first = forwardItems.first {
                            page.load(first)
                        }
                    }label: {
                        Image(systemName: "chevron.forward")
                    }
                    .disabled(forwardItems.isEmpty)
                    Button {
                        page.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    Button {
                        page.stopLoading()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .disabled(!page.isLoading)
                }
            }
        }
        .onAppear {
            let url = URL(string: "https://www.swift.org")
            let navigationDecider = NavigationDecider(disableURL: $disableURL)
            page = WebPage(navigationDecider: navigationDecider)
            page.load(url)
        }
        .alert("Disabled", isPresented: .constant(disableURL != nil)) {
            Button("OK") {}
        } message: {
            Text("\(disableURL ?? "") is oudside of this domain.")
        }

    }
}

struct NavigationDecider: WebPage.NavigationDeciding {
    @Binding var disableURL: String?
    func decidePolicy(for action: WebPage.NavigationAction, preferences: inout WebPage.NavigationPreferences) async -> WKNavigationActionPolicy {
        let url = action.request.url
        if url?.host() == "www.swift.org" {
            return .allow
        }
        disableURL = url?.host()
        return .cancel
    }
}

#Preview {
    WebViewWithNavigationDeciding()
}
