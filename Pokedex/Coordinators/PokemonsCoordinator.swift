//
//  PokemonsCoordinator.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class PokemonsCoordinator: CoordinatorProtocol {

    var childCoordinators: [CoordinatorProtocol] = []

    var navigationController: NavigationController

    required init(_ navigationController: NavigationController = NavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let detailPokemonPersisten:Int? = nil
        if let detailPokemonPersisten = detailPokemonPersisten{
            let viewModel = ListViewModel(api: PokeAPI.shared)
            showDetailViewController(with: viewModel.pokemons[detailPokemonPersisten])
        } else {
            showListViewController()
        }
    }

    func showListViewController() {

        // Instantiate ListViewModel
        let viewModel = ListViewModel(api: PokeAPI.shared)

        // Instantiate HostingController with the view and view model
        let hostingController = HostingController<ListView>(viewModel: viewModel)

        // Set the Coordinator to the ViewModel
        viewModel.coordinator = self

        // Add viewcontroller into navigation controller
        navigationController.setViewControllers([hostingController], animated: false)
    }

    var presentAsModalPresentationStyle: Bool = false

    func showDetailViewController(with pokemon: Pokemon) {

        // Instantiate ListViewModel
        let viewModel = DetailViewModel(pokemon: pokemon)

        // Instantiate HostingController with the view and view model
        let hostingController = HostingController<DetailView>(viewModel: viewModel)

        // Set the Coordinator to the ViewModel
        viewModel.coordinator = self

        if presentAsModalPresentationStyle {
            hostingController.modalPresentationCapturesStatusBarAppearance = true
            // Present above navigation view controller
            navigationController.present(hostingController, animated: true, completion: nil)
        } else {
            hostingController.statusBarStyle = .lightContent
            // Push into navigation view controller
            navigationController.pushViewController(hostingController, animated: true)
        }
    }

    func dismissDetailViewController() {
        if presentAsModalPresentationStyle {
            let viewController = navigationController.visibleViewController
            viewController?.dismiss(animated: true, completion: nil)
        }
    }

}
