//
//  BreakingBadCharactersTests.swift
//  BreakingBadCharactersTests
//
//  Created by Cognitven on 19.10.21.
//

import XCTest
import Combine
@testable import BreakingBadCharacters

class CharacterEndpointTests: XCTestCase {

    var characterEndpoint = MockCharacterEndpoint(url: Path.characters.path)
    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testSuccessfulRequest() throws {
        characterEndpoint.get()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                switch value {
                    case .failure(_):
                        break
                    case .finished:
                        break
                }
            }, receiveValue: { [weak self] characters in
                if let data = try? JSONDecoder().decode(CharactersResponse.self, from: characters) {
                    // vallidate recieved data
                }
            })
            .store(in: &disposables)
    }

    func testRequestWithError() throws {

    }

}
