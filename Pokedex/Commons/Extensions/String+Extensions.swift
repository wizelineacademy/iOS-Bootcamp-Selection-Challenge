//
//  String+Extensions.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import Foundation

extension String {

    func matches(_ pattern: String) -> [[String]] {
        let range = NSRange(self.startIndex..., in: self)
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let matches = regex.matches(in: self, options: [], range: range)

        var groups: [[String]] = []

        for match in matches {
            var subgroup: [String] = []
            // For each matched range, extract the capture group
            for index in 0..<match.numberOfRanges {
                let matchRange = match.range(at: index)
                // Extract the substring matching the capture group
                if let substringRange = Range(matchRange, in: self) {
                    let capture = String(self[substringRange])
                    subgroup.append(capture)
                }
            }
            groups.append(subgroup)
        }
        return groups
    }

}
