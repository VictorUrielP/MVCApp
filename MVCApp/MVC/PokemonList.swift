//
//  PokemonList.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import Foundation

final class PokemonList {
    private let pokedex: PokeDex
    private(set) lazy var pokemons: [Pokemon] = Array(pokedex.pokemons.prefix(4))

    init(pokedex: PokeDex) {
        self.pokedex = pokedex
    }
    
    // MARK: - Computed properties
    var numberOfItems: Int {
        pokemons.count
    }
    
    // MARK: Pokemon List Operations
    func pokemon(at index: Int) -> Pokemon {
        pokemons[index]
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }

    func removePokemon(at index: Int) {
        pokemons.remove(at: index)
    }
}
