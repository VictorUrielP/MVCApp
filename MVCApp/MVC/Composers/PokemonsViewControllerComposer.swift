//
//  PokemonsViewControllerComposer.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import Foundation

enum PokemonsViewControllerComposer {

    static func make(pokedex: PokeDex = PokeDex()) -> PokemonsViewController {
        let pokemonList = PokemonList(pokedex: pokedex)
        let pokemonAggregator = PokemonAggregator(pokedex: pokedex)
        let addPokemonController = AddPokemonController(pokemonAggregator: pokemonAggregator, pokemonList: pokemonList)
        let removePokemonController = RemovePokemonController(pokemonList: pokemonList)
        let pokemonsViewController = PokemonsViewController(pokemonList: pokemonList, addPokemonController: addPokemonController, removePokemonController: removePokemonController)
        return pokemonsViewController
    }
}
