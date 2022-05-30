//
//  CoordinatorProtocol.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

protocol CoordinatorProtocol {
    /// child coordinator object to hold reference
    var childCoordinators: [CoordinatorProtocol] { get set }
    /// main controller to handle the navigation
    var navigationController: NavigationController { get }
    /// main function to start the navigation
    func start()
    /// init with navigation controller for nested navigation
    init(_ navigationController: NavigationController)
}
