//
//  ListView.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

struct ListView: ViewProtocol {

    var viewModel: ListViewModelProtocol

    let collectionView: ListViewCollectionView

    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        self.collectionView = ListViewCollectionView(viewModel: viewModel)
        self.viewModel.collectionView = collectionView
    }

    var body: UIView {
        // Set up the refresh control as part of the collection view when it's pulled to refresh.
        let handler = viewModel.refreshHandler
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(handler, for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)

        handler.fire()

        return collectionView
    }

    func willAppear(on viewController: UIViewController, animated: Bool) {
        let tintColor: UIColor = .systemBlue
        let backgroundColor: UIColor = .white
        let foregroundColor: UIColor = .black
        
        // customize navigation bar.
        let navigationBar = viewController.navigationController?.navigationBar
        navigationBar?.tintColor = tintColor
        navigationBar?.prefersLargeTitles = true
        navigationBar?.standardAppearance.backgroundColor = backgroundColor
        navigationBar?.standardAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navigationBar?.standardAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]

        navigationBar?.scrollEdgeAppearance = navigationBar?.standardAppearance
        navigationBar?.scrollEdgeAppearance?.configureWithTransparentBackground()

        // set current view controller's title
        viewController.title = viewModel.title

        // Set up the searchController parameters.
        viewController.navigationItem.searchController = viewModel.searchBarController
        viewController.definesPresentationContext = true
    }

}
