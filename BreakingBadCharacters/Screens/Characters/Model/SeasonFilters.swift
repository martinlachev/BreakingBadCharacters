//
//  SeasonFilters.swift
//  BreakingBadCharacters
//
//  Created by Cognitven on 24.10.21.
//

import Foundation

struct SeasonFilters: Identifiable, Equatable {
    let id: Int
    let name: String
    var isSelected: Bool = false

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
