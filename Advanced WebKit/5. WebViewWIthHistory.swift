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
import WebKit

struct WebViewWithHistory: View {
    @State private var page = WebPage()
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
                    .ignoresSafeArea(edges: .bottom)
            }
            .navigationTitle(page.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItemGroup(placement: .bottomBar) {
                    Image(systemName: "chevron.backward")
                        .onTapGesture {
                            if let last = backItems.last {
                                page.load(last)
                            }
                        }
                    .disabled(backItems.isEmpty)
                    .contextMenu {
                        ForEach(backItems.indices.reversed(), id: \.self) { index in
                            let item = backItems[index]
                            Button(historyLabel(for: item)) {
                                page.load(item)
                            }
                        }
                    }
                    Image(systemName: "chevron.forward")
                        .onTapGesture {
                            if let first = forwardItems.first {
                                page.load(first)
                            }
                        }
                    .disabled(forwardItems.isEmpty)
                    .contextMenu {
                        ForEach(forwardItems.indices, id: \.self) { index in
                            let item = forwardItems[index]
                            Button(historyLabel(for: item)) {
                                page.load(item)
                            }
                        }
                    }
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
            page.load(url)
        }
    }
    
    func historyLabel(for item: WebPage.BackForwardList.Item) -> String {
        if let title = item.title?.trimmingCharacters(in: .whitespacesAndNewlines),
           !title.isEmpty {return title}
        if let host = item.url.host(),
           !host.isEmpty {return host }
        return item.url.absoluteString
    }
}

#Preview {
    WebViewWithHistory()
}
