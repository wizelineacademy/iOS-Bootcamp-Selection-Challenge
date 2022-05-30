//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation
import Combine

class PokeAPI: APIClientProtocol {

    static let shared = PokeAPI(session: .shared)

    let session: URLSession

    required init(session: URLSession) {
        self.session = session
    }

    // TODO: Implements generics to merge this methods into one

    public func request(endpoint: PokeListEndpoint) -> AnyPublisher<PokemonList, Error>? {
        guard let request = URLRequest(endpoint: endpoint) else { return nil }

        let publisher = session.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard
                    let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: PokemonList.self, decoder: JSONDecoder())
        return publisher.eraseToAnyPublisher()
    }

    public func request(endpoint: PokeDetailEndpoint) -> AnyPublisher<Pokemon, Error>? {
        guard let request = URLRequest(endpoint: endpoint) else { return nil }

        let publisher = session.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard
                    let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
        return publisher.eraseToAnyPublisher()
    }

}
