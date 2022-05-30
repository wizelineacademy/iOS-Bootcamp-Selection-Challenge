//
//  DetailViewModelTests.swift
//  PokedexTests
//
//  Created by Jorge Benavides
//

import XCTest
@testable import Pokedex

class DetailViewTests: XCTestCase {
    // our system under test (sut)
    var viewModel: DetailViewModel!

    // bundle for PokedexTest target
    lazy var bundle = Bundle(for: self.classForCoder)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let data = try Data.from(filename: "pokemon_raw", in: bundle, ofType: "json")!

        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)

        viewModel = DetailViewModel(pokemon: pokemon)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testPokemonNameCapitalize() throws {
        // This is an example of a functional test case.
        XCTAssertEqual(viewModel.title, "Ditto", "something is wrong with the pokemon's name")
    }

    func testPokemonIDFormat() throws {
        // This is an example of a functional test case.
        XCTAssertEqual(viewModel.pokemonID, "#132", "something is wrong with the pokemon's id")
    }

    func testPokemonWeightUnits() throws {
        // This is an example of a functional test case.
        let string = viewModel.pokemonWeight
        let range = string.range(of: "kg$", options: .regularExpression)
        XCTAssertNotNil(range, "something is wrong with the pokemon's weight units")
    }

}

