//
//  ApiError.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 19.10.21.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    case parsing(description: String)
    case network(description: String)
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        case .parsing(description: let description):
            return description
        case .network(description: let description):
            return description
        }
    }
}
