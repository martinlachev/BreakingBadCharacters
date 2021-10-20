//
//  Path.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 20.10.21.
//

import Foundation

enum Path {
    case characters

    var path: String {
        switch self {
            case .characters:
                return "\(Constants.baseUrl)/\(Constants.apiVersion)/characters"
        }
    }
}
