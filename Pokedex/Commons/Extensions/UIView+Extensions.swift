//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

extension UIView {
    
    func addGradient(colors: [UIColor], with locations: [NSNumber] = [0.0, 1.0]) {
        layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.locations = locations
        gradient.colors = colors.map { $0.cgColor }
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }

}
