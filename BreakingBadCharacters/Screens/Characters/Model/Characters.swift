//
//  Characters.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 20.10.21.
//

import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let imageUrl: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case imageUrl = "img"
        case name = "name"
    }
}
