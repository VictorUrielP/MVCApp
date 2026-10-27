//
//  AddPokemonController.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import UIKit

final class AddPokemonController {
    private(set) lazy var barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    private let pokemonAggregator: PokemonAggregator
    private let pokemonList: PokemonList
    
    var didAddPokemon: (() -> Void)?

    init(pokemonAggregator: PokemonAggregator, pokemonList: PokemonList) {
        self.pokemonAggregator = pokemonAggregator
        self.pokemonList = pokemonList
    }
    
    @objc private func addButtonPressed() {
        guard let pokemon = pokemonAggregator.nextPokemon(notIn: pokemonList.pokemons) else { return }
        pokemonList.append(pokemon)
        didAddPokemon?()
    }
}
