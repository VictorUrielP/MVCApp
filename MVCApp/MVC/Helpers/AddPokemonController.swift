//
//  AddPokemonController.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import UIKit

final class AddPokemonController {
    private(set) lazy var view = UIButton.systemButton(with: .add, target: self, action: #selector(addButtonPressed))
    private let pokemonAggregator: PokemonAggregator
    private let pokemonList: PokemonList
    
    var didAddPokemon: (() -> Void)?

    init(pokemonAggregator: PokemonAggregator, pokemonList: PokemonList) {
        self.pokemonAggregator = pokemonAggregator
        self.pokemonList = pokemonList
    }
    
    @objc func addButtonPressed() {
        guard let pokemon = pokemonAggregator.addPokemon(pokemons: pokemonList.pokemons) else { return }
        pokemonList.addPokemon(pokemon: pokemon)
        didAddPokemon?()
    }
}
