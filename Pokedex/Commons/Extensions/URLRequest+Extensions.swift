//
//  URLRequest+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

extension URLRequest {
    
    init?(endpoint: Endpoint) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.baseURL + endpoint.path
        components.queryItems = endpoint.params.map({ URLQueryItem(name: $0, value: "\($1)") })

        guard let url = components.url else { return nil }

        self.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
    }

}
