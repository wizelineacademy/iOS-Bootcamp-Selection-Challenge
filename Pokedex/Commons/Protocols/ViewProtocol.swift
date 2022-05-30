//
//  ViewProtocol.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

protocol ViewProtocol {
    associatedtype ViewModelProtocol
    /// view object to layout
    var body: UIView { get }
    /// view reference to his dependency view model
    var viewModel: ViewModelProtocol { get }
    /// required initialization with view model
    init(viewModel: ViewModelProtocol)

    // methods with default implementation
    func layout()
    func didLoad(on viewController: UIViewController)
    func didAppear(on viewController: UIViewController, animated: Bool)
    func willAppear(on viewController: UIViewController, animated: Bool)
    func didDisappear(on viewController: UIViewController, animated: Bool)
    func willDisappear(on viewController: UIViewController, animated: Bool)
}

extension ViewProtocol {
    func layout() {}
    func didLoad(on viewController: UIViewController) {}
    func didAppear(on viewController: UIViewController, animated: Bool) {}
    func willAppear(on viewController: UIViewController, animated: Bool) {}
    func didDisappear(on viewController: UIViewController, animated: Bool) {}
    func willDisappear(on viewController: UIViewController, animated: Bool) {}
}
