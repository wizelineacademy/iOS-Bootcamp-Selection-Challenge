//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

struct Pokemon: Decodable, Equatable {

    let id: Int
    let name: String
    let image: String?
    let types: [String]?
    let abilities: [String]?
    let weight: Float
    let baseExperience: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case types
        case abilities
        case weight
        case baseExperience = "base_experience"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try? container.decode(String.self, forKey: .image)

        // TODO: Decode the rest of the properties

        self.types = []
        self.abilities = []
        self.weight = 0
        self.baseExperience = 0
    }

}
