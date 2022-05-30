//
//  Endpoint.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var baseURL: String { get }
    var path: String { get }
    var params: [String: Any] { get }
}

extension Endpoint {
    var params: [String: Any] { [:] }
}
