//
//  URL+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

extension URL {

    static func from(string: String?) -> URL? {
        guard let string = string else { return nil }
        return URL(string: string)
    }

}
