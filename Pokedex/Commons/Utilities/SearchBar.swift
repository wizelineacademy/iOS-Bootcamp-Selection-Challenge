//
//  SearchBar.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    func updateSearchResults(for text: String)
}

protocol SearchBarProtocol: UISearchController & UISearchBarDelegate & UISearchResultsUpdating {
    var searchBarDelegate: SearchBarDelegate? { get set }

    var text: String? { get set }

    var isSearchBarEmpty: Bool { get }

    var isFiltering: Bool { get }

    var showsCancelButton: Bool { get set }
}

class SearchBar: UISearchController, SearchBarProtocol {

    public weak var searchBarDelegate: SearchBarDelegate?

    public var text: String? {
        get {
            searchBar.text
        }
        set {
            searchBar.text = newValue
        }
    }

    public var isSearchBarEmpty: Bool {
      searchBar.text?.isEmpty ?? true
    }

    public var isFiltering: Bool {
      isActive && !isSearchBarEmpty
    }

    public var showsCancelButton: Bool = false {
        didSet {
            searchBar.showsCancelButton = showsCancelButton
        }
    }

    init(_ placeholder: String?, delegate: SearchBarDelegate? = nil) {
        self.searchBarDelegate = delegate
        super.init(searchResultsController: nil)
        self.obscuresBackgroundDuringPresentation = false
        self.searchResultsUpdater = self
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showsCancelButton = true
        searchBarDelegate?.searchBarTextDidBeginEditing(searchBar)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        showsCancelButton = !isSearchBarEmpty
        searchBarDelegate?.searchBarTextDidEndEditing(searchBar)
    }

    func updateSearchResults(for searchController: UISearchController) {
        searchBarDelegate?.updateSearchResults(for: text ?? "")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

}
