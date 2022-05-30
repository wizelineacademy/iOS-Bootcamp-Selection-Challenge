//
//  ListViewModelTests.swift
//  PokedexTests
//
//  Created by Jorge Benavides
//

import XCTest
import Combine
@testable import Pokedex

class ListViewModelTesting: ListViewModel {
    // create an expectation for the test
    let expectation = XCTestExpectation(description: "this should contain 3 pokemons")
    // override completion method to fulfill expectation test
    override func didRefresh() {
        expectation.fulfill()
    }
}

class ListViewModelTests: XCTestCase {
    // our system under test (sut)
    var viewModel: ListViewModelTesting!

    // bundle for PokedexTest target
    lazy var bundle = Bundle(for: self.classForCoder)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let pokemonListData = try Data.from(filename: "pokemons_raw", in: bundle, ofType: "json")
        let pokemonDetailData = try Data.from(filename: "pokemon_raw", in: bundle, ofType: "json")

        let api = APIClientMock(pokemonListData: pokemonListData, pokemonDetailData: pokemonDetailData)

        viewModel = ListViewModelTesting(api: api)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testRefreshMethodHasPokemons() throws {
        // This is an example of a functional test case.
        // Given

        // When
        viewModel.refresh()

        // Then
        wait(for: [viewModel.expectation], timeout: 10)
        XCTAssertGreaterThanOrEqual(viewModel.pokemons.count, 1, "There is no pokemons at refresing view model")
    }

}

class APIClientMock: APIClientProtocol {
    // conform the api client protocol
    var session: URLSession
    required init(session: URLSession = .shared) {
        self.session = session
    }

    // static endpoint data for pokemon's list
    var pokemonListData: Data?
    // static endpoint data for pokemon detail
    var pokemonDetailData: Data?
    // custom init for test
    convenience init(pokemonListData: Data?, pokemonDetailData: Data?) {
        self.init(session: .shared)
        self.pokemonListData = pokemonListData
        self.pokemonDetailData = pokemonDetailData
    }
    // return publisher for the 2 known endpoints that are use on sut method
    func request(endpoint: PokeListEndpoint) -> AnyPublisher<PokemonList, Error>? {
        let publisher = Just<Data?>(pokemonListData)

        return publisher
            .compactMap { element -> Data? in
                element
            }
            .decode(type: PokemonList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func request(endpoint: PokeDetailEndpoint) -> AnyPublisher<Pokemon, Error>? {
        let publisher = Just<Data?>(pokemonDetailData)

        return publisher
            .compactMap { element -> Data? in
                element
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
