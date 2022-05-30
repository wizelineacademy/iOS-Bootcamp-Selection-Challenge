//
//  APIClientProtocol.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation
import Combine

protocol APIClientProtocol {
    var session: URLSession { get }
    init(session: URLSession)
    func request(endpoint: PokeListEndpoint) -> AnyPublisher<PokemonList, Error>?
    func request(endpoint: PokeDetailEndpoint) -> AnyPublisher<Pokemon, Error>?
}
