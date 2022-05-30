//
//  DetailViewModel.swift
//  PokemonCard
//
//  Created by Jorge Benavides
//

import UIKit

protocol DetailViewModelProtocol: ViewModelProtocol {
    var title: String { get }
    var pokemonName: String { get }
    var primaryType: String? { get }
    var secondaryType: String? { get }
    var pokemonID: String { get }
    var pokemonTypes: [String] { get }
    var pokemonImageURL: URL? { get }
    var pokemonAbilities: [String]  { get }
    var pokemonWeight: String { get }
    var pokemonExperience: String { get }
    var dismissHandler: TargetHandler { get }
}

class DetailViewModel: DetailViewModelProtocol {

    var title: String {
        pokemonName
    }

    let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    weak var coordinator: PokemonsCoordinator?

    var primaryType: String? {
        pokemon.types?.first?.capitalized
    }

    var secondaryType: String? {
        guard let types = pokemon.types else { return nil }
        return types.indices.contains(1) ? types[1].capitalized : nil
    }

    var pokemonName: String {
        pokemon.name.capitalized
    }

    var pokemonID: String {
        String(format: "#%03d", arguments: [pokemon.id])
    }

    var pokemonTypes: [String] {
        pokemon.types ?? []
    }

    var pokemonImageURL: URL? {
        guard let string = pokemon.image else { return nil }
        let endpoint = PokeImageEndpoint(path: string)
        return URLRequest(endpoint: endpoint)?.url
    }

    var pokemonAbilities: [String] {
        pokemon.abilities ?? []
    }

    var pokemonWeight: String {
        "\(pokemon.weight/10) kg"
    }

    var pokemonExperience: String {
        "\(pokemon.baseExperience)"
    }

    lazy var dismissHandler: TargetHandler = {
        TargetHandler(handler: { [weak self] sender in
            self?.coordinator?.dismissDetailViewController()
        })
    }()

}

extension DetailViewModel: CustomDebugStringConvertible {
    var debugDescription: String {
        pokemonName
    }
}
