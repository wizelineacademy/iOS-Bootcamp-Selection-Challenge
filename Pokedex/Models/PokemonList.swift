//
//  PokemonList.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

struct PokemonList: Decodable {

    let results: [PokemonItem]
    let count: Int

    enum CodingKeys: String, CodingKey {
        case results
        case count
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([PokemonItem].self, forKey: .results)
        self.count = try container.decode(Int.self, forKey: .count)
    }

}

struct PokemonItem: Decodable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
