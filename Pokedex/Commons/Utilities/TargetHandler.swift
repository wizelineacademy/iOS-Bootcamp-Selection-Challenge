//
//  TargetHandler.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

// wrapp class for objc target selectors
class TargetHandler {

    private let handler: (Any?) -> Void

    init(handler: @escaping((Any?) -> Void)) {
        self.handler = handler
    }

    @objc func fire() {
        fire(nil)
    }

    @objc func fire(_ sender: Any?) {
        handler(sender)
    }
}
