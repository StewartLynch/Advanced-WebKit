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

import Foundation

enum BundleManager {
    enum BundleError: Error {
        case resourceNotFound
        case readFailed(Error)
    }
    
    static func loadHTML(named name: String,
                         ext: String = "html",
                         bundle: Bundle = .main) throws -> String {
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            throw BundleError.resourceNotFound
        }
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            throw BundleError.readFailed(error)
        }
    }
}
