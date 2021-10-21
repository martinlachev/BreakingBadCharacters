//
//  CharacterEndpoint.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 21.10.21.
//

import Combine
import Foundation

class CharacterEndpoint: ApiClientProtocol {
    var url: String {
        return Path.characters.path
    }

    func get() -> AnyPublisher<Data, ApiError> {
        guard let url = URL(string: url ) else {
            let error = ApiError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return sessionPublisher(request: request)
    }
}
