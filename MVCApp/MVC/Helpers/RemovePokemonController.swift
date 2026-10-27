//
//  RemovePokemonController.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import UIKit

final class RemovePokemonController {
    private(set) lazy var view = UIButton.systemButton(with: .remove, target: self, action: #selector(removeButtonPressed))
    private let pokemonList: PokemonList

    /// Reads the current selection from the view, which owns it.
    var selectedIndex: (() -> Int?)?
    var didRemovePokemon: (() -> Void)?

    init(pokemonList: PokemonList) {
        self.pokemonList = pokemonList
    }
    
    func selectionDidChange() {
        view.isEnabled = selectedIndex?() != nil
    }
    
    @objc func removeButtonPressed() {
        guard let index = selectedIndex?() else { return }
        pokemonList.remove(at: index)
        didRemovePokemon?()
    }
}
