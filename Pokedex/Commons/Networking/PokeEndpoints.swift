//
//  PokeEndpoints.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

protocol PokeEndpoint: Endpoint { }

extension PokeEndpoint {
    var scheme: String { "https" }
    var host: String { "raw.githubusercontent.com" }
    var baseURL: String { "/wizeline/mock-api/main/pokedex/v1" }
}

struct PokeListEndpoint: PokeEndpoint {
    let limit: Int
    var path: String { "/pokemons/all.json" }
    var params: [String : Any] { ["limit": limit] }
}

struct PokeDetailEndpoint: PokeEndpoint {
    let id: Int
    var path: String { "/pokemon/\(id).json" }
}
