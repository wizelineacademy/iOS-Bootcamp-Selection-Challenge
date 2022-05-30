//
//  ViewControllerProtocol.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

protocol ViewControllerProtocol {
    associatedtype ViewProtocol
    associatedtype ViewModelProtocol
    /// view controllers reference to retain the view
    var viewObject: ViewProtocol? { get }
    /// view controllers reference to view model for the dependency initialization
    var viewModelObject: ViewModelProtocol { get }
    /// required initialization with view model
    init(viewModel: ViewModelProtocol)
}
