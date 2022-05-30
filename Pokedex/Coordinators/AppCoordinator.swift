//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class AppCoordinator: CoordinatorProtocol {

    var navigationController: NavigationController

    var childCoordinators: [CoordinatorProtocol] = []

    required init(_ navigationController: NavigationController = NavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        showListViewController()
    }

    func showListViewController() {

        let pokemonsCoordinator = PokemonsCoordinator(navigationController)
        pokemonsCoordinator.start()

        childCoordinators.append(pokemonsCoordinator)
    }

}
