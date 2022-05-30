//
//  UIControl+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

extension UIControl {

    func addTarget(_ handler: TargetHandler, for controlEvents: UIControl.Event) {
        addTarget(handler, action: #selector(handler.fire(_:)), for: controlEvents)
    }

    func removeTarget(_ handler: TargetHandler, for controlEvents: UIControl.Event) {
        removeTarget(handler, action: #selector(handler.fire(_:)), for: controlEvents)
    }

}
