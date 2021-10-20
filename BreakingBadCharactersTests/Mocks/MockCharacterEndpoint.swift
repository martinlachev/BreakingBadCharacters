//
//  MockApiClient.swift
//  BreakingBadCharactersTests
//
//  Created by Cognitven on 20.10.21.
//

import Foundation
import Combine
@testable import BreakingBadCharacters

class MockCharacterEndpoint: ApiClientProtocol {
    var url: String

    init(url: String) {
        self.url = url
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
