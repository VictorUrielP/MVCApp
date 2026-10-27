//
//  TestHelpers.swift
//  MVCAppTests
//

import UIKit
@testable import MVCApp

func makePokemon(id: Int) -> Pokemon {
    Pokemon(id: id,
            name: "pokemon-\(id)",
            image: "p.pokemon-\(id)",
            weight: 1,
            base_experience: 1,
            types: [],
            abilities: [])
}

func makePokedex(ids: [Int]) -> PokeDex {
    PokeDex(pokemons: ids.map(makePokemon(id:)))
}

extension UIBarButtonItem {
    /// Sends the item's action to its target, the same way UIKit does on a tap.
    func simulateTap() {
        guard let action = action else { return }
        _ = UIApplication.shared.sendAction(action, to: target, from: self, for: nil)
    }
}
