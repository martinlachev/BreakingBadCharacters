//
//  ApiClientProtocol.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 19.10.21.
//

import Foundation
import Combine

protocol ApiClientProtocol {
    var url: String { get }
    func get() -> AnyPublisher<Data, ApiError>
}

extension ApiClientProtocol {
    internal func sessionPublisher(request: URLRequest) -> AnyPublisher<Data, ApiError> {
        let session: URLSession = .shared
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<400 ~= httpResponse.statusCode else {
                    if let data = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        throw ApiError.apiError(reason: data.error)
                    }

                    throw ApiError.unknown
                }

                return data
            }
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
