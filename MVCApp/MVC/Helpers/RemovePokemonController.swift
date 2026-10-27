//
//  RemovePokemonController.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import UIKit

final class RemovePokemonController {
    private(set) lazy var barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeButtonPressed))
    private let pokemonList: PokemonList

    /// Reads the current selection from the view, which owns it.
    var selectedIndex: (() -> Int?)?
    var didRemovePokemon: ((_ index: Int) -> Void)?

    init(pokemonList: PokemonList) {
        self.pokemonList = pokemonList
    }
    
    func selectionDidChange() {
        barButtonItem.isEnabled = selectedIndex?() != nil
    }
    
    @objc private func removeButtonPressed() {
        guard let index = selectedIndex?() else { return }
        pokemonList.remove(at: index)
        didRemovePokemon?(index)
    }
}
