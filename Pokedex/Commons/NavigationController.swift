//
//  NavigationController.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class NavigationController: UINavigationController {

    override public var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .default
    }

}
