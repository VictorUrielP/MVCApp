//
//  PokemonAggregator.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

final class PokemonAggregator {
    private let pokedex: PokeDex

    init(pokedex: PokeDex) {
        self.pokedex = pokedex
    }
    
    func nextPokemon(notIn pokemons: [Pokemon]) -> Pokemon? {
        pokedex.pokemons.first { candidate in
            !pokemons.contains { $0.id == candidate.id }
        }
    }
}
