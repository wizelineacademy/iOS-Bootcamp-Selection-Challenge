//
//  PokemonType.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

enum PokemonType: String, Decodable, CaseIterable, Identifiable {

    var id: String { rawValue }

    case fire
    case grass
    case water
    case poison
    case flying
    case electric
    case bug
    case normal
    case fighting
    case ice
    case ground

}
