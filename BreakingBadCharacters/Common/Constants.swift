//
//  Constants.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 20.10.21.
//

import Foundation
import SwiftUI

struct Constants {
    static let baseUrl: String = "https://breakingbadapi.com"
    static let apiVersion: String = "api"
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
