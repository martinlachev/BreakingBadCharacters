//
//  BreakingBadCharactersTests.swift
//  BreakingBadCharactersTests
//
//  Created by Cognitven on 19.10.21.
//

import XCTest
import Combine
@testable import Breaking_Bad_Characters

class CharacterEndpointTests: XCTestCase {

    var characterEndpoint = MockCharacterEndpoint(url: Path.characters.path)
    var characterEndpointWithWrongPath = MockCharacterEndpoint(url: "https://breakingbadapi.com/api/characters/dasd")
    private var disposables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testSuccessfulRequest() throws {
        characterEndpoint.get()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                    case .failure(_):
                        break
                    case .finished:
                        break
                }
            }, receiveValue: { characters in
                if let _ = try? JSONDecoder().decode([Character].self, from: characters) {
                    XCTAssert(true)
                } else {
                    XCTAssert(false)
                }
            })
            .store(in: &disposables)
    }

    func testRequestWithError() throws {
        characterEndpointWithWrongPath.get()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                    case .failure(let error):
                        if let _ = error.errorDescription {
                            XCTAssert(true)
                        } else {
                            XCTAssert(false)
                        }
                    case .finished:
                        break
                }
            }, receiveValue: { characters in

            })
            .store(in: &disposables)
    }

}
