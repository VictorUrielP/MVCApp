//
//  PokemonsViewControllerComposer.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import Foundation

enum PokemonsViewControllerComposer {

    static func make(pokedex: PokeDex = PokeDex()) -> PokemonsViewController {
        let pokemonsViewModel = PokemonsViewModel(pokedex: pokedex)
        let pokemonAggregator = PokemonAggregator(pokedex: pokedex)
        let addPokemonController = AddPokemonController(pokemonAggregator: pokemonAggregator, pokemonsViewModel: pokemonsViewModel)
        let removePokemonController = RemovePokemonController(pokemonsViewModel: pokemonsViewModel)
        let pokemonsViewController = PokemonsViewController(viewModel: pokemonsViewModel, addPokemonController: addPokemonController, removePokemonController: removePokemonController)
        return pokemonsViewController
    }
}
