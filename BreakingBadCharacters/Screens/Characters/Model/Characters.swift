//
//  Characters.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 20.10.21.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let imageUrl: String
    let name: String
    let occupation: [String]
    let seasonAppearance: [Int]
    let status: String
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case imageUrl = "img"
        case name = "name"
        case occupation
        case seasonAppearance = "appearance"
        case status
        case nickname
    }
}
