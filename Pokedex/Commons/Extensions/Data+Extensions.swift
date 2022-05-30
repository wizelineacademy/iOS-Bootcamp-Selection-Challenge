//
//  Data+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

extension Data {

    static func from(filename: String, in bundle: Bundle, ofType: String) throws -> Data? {
        guard let filepath = bundle.path(forResource: filename, ofType: ofType) else { return nil }
        let json: String = try String(contentsOfFile: filepath)
        return Data(json.utf8)
    }
    
}
