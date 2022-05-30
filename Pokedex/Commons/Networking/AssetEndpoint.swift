//
//  AssetEndpoint.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

protocol AssetEndpoint: Endpoint { }

extension AssetEndpoint {
    var scheme: String { "https" }
    var host: String { "raw.githubusercontent.com" }
    var baseURL: String { "/wizeline/mock-api/main" }
}

struct PokeImageEndpoint: AssetEndpoint {
    var path: String
}
