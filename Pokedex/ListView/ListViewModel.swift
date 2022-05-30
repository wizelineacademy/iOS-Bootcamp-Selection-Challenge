//
//  ListViewModel.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Combine
import UIKit

protocol ListViewModelProtocol: ViewModelProtocol {
    var title: String { get }
    var searchBarController: SearchBarProtocol { get }
    var collectionView: ListViewCollectionView? { get set }
    var refreshHandler: TargetHandler { get }
    var numberOfPokeCells: Int { get }
    func pokemon(at index: Int) -> PokeCellElement
}

class ListViewModel: ListViewModelProtocol {

    let title = "Pokédex"
    let api: APIClientProtocol
    let searchBar: SearchBarProtocol

    init(api: APIClientProtocol, searchBar: SearchBarProtocol = SearchBar("Search pokemon")) {
        self.api = api
        self.searchBar = searchBar
    }

    weak var collectionView: ListViewCollectionView?
    weak var coordinator: PokemonsCoordinator?

    private var _filterString: String { latestSearch ?? "" }
    private var _pokemons: [Pokemon] = []
    var pokemons: [Pokemon] {
        get {
            _pokemons
                .filter { _filterString.isEmpty || $0.name.lowercased().contains(_filterString.lowercased()) }
                .sorted { $0.id < $1.id }
        }
        set {
            _pokemons = newValue
        }
    }

    var numberOfPokeCells: Int {
        pokemons.count
    }

    func pokemon(at index: Int) -> PokeCellElement {
        let pokemon = pokemons[index]

        var image: URL?
        if let string = pokemon.image {
            let endpoint = PokeImageEndpoint(path: string)
            image = URLRequest(endpoint: endpoint)?.url
        }
        return PokeCellElement(id: String(format: "#%03d", arguments: [pokemon.id]),
                               name: pokemon.name.capitalized,
                               image: image,
                               primaryType: pokemon.types?.first,
                               types: pokemon.types ?? [])
    }

    lazy var cancelBag = Set<AnyCancellable>()

    lazy var refreshHandler: TargetHandler = {
        TargetHandler(handler: { sender in
            self.refresh()
        })
    }()

    lazy var searchBarController: SearchBarProtocol = {
        searchBar.searchBarDelegate = self
        searchBar.text = latestSearch
        searchBar.showsCancelButton = !searchBar.isSearchBarEmpty
        return searchBar
    }()

    // TODO: Use UserDefaults to pre-load the latest search at start
    
    private var latestSearch: String?

    // TODO: Add a loading indicator when the app first launches and has no pokemons

    private var shouldShowLoader: Bool = false

    func refresh() {
        
        shouldShowLoader = true

        // TODO: Wait for all requests to finish before updating the collection view

        self.pokemons = []
        self.pokemonsPublisher()?
            .sink(receiveCompletion: { [weak self] completion in
                self?.didRefresh()
            }, receiveValue: { pokemonList in
                pokemonList.results.forEach { [weak self] in
                    guard let self = self else { return }
                    self.pokemonPublisher(for: $0.id)?
                        .sink(receiveCompletion: { completion in
                            self.didRefresh()
                        }, receiveValue: { pokemon in
                            self.pokemons.append(pokemon)
                        })
                        .store(in: &self.cancelBag)
                }
            })
            .store(in: &cancelBag)
    }

    private func pokemonsPublisher() -> AnyPublisher<PokemonList, Error>? {
        self.api.request(endpoint: PokeListEndpoint(limit: 150))
    }

    private func pokemonPublisher(for id: Int) -> AnyPublisher<Pokemon, Error>? {
        self.api.request(endpoint: PokeDetailEndpoint(id: id))
    }

    func didRefresh() {

        shouldShowLoader = false

        collectionView?.reload()
    }

}

extension ListViewModel: SearchBarDelegate {

    // MARK: - SearchBarDelegate

    // TODO: Implement the SearchBar
    
    func updateSearchResults(for text: String) {

    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }

}

extension UserDefaults.Key {
    static let searchedText = UserDefaults.Key(rawValue: "kSearchedText")
}
