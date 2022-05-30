//
//  PokemonColor.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

struct PokemonColor {

    static func gradientColors(for type: String?) -> [UIColor] {
        guard
            let type = type,
            let pokeType = PokemonType(rawValue: type)
        else { return [] }
        return [UIColor.pokemon(pokeType), UIColor.pokemon(pokeType, alternative: true)]
    }
}

