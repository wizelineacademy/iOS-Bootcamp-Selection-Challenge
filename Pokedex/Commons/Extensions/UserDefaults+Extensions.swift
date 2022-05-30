//
//  UserDefaults+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

extension UserDefaults {

    struct Key: RawRepresentable {
        var rawValue: String
    }
    
    func set(_ any: Any?, forKey key: UserDefaults.Key) {
        self.set(any, forKey: key.rawValue)
    }

    func string(forKey key: UserDefaults.Key) -> String? {
        self.string(forKey: key.rawValue)
    }

}
