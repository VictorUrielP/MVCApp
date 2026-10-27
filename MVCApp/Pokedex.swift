//
//  Pokedex.swift
//  MVCApp
//
//  Created by Jorge Benavides
//

import Foundation
import os

final class PokeDex {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "MVCApp", category: "PokeDex")

    let pokemons: [Pokemon]

    init(pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }

    convenience init(bundle: Bundle = .main) {
        self.init(pokemons: PokeDex.loadPokemons(from: bundle))
    }

    private static func loadPokemons(from bundle: Bundle) -> [Pokemon] {
        guard let url = bundle.url(forResource: "pokemons", withExtension: "json") else {
            logger.error("pokemons.json is missing from the app bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Pokemon].self, from: data)
        } catch {
            logger.error("Failed to load pokemons.json: \(String(describing: error), privacy: .public)")
            return []
        }
    }
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let image: String
    let weight: Int
    let base_experience: Int
    let types: [String]
    let abilities: [String]
}
