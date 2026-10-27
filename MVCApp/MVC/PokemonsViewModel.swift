//
//  PokemonsDataModel.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import Foundation
import UIKit

final class PokemonsViewModel: NSObject {
    private let pokedex = PokeDex()
    private(set) lazy var pokemons: [Pokemon] = Array(pokedex.pokemons.prefix(4))
    
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
    
    func getLastIndexPath() -> IndexPath? {
        guard numberOfItems > 0 else { return nil }
        return IndexPath(row: numberOfItems - 1, section: 0)
    }
}

// MARK: - UITableViewDataSource
extension PokemonsViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellController = tableView.dequeueReusableCell(withIdentifier: "PokemonCellController", for: indexPath) as? PokemonCellController else { return UITableViewCell() }
        let pokemon = pokemon(at: indexPath.row)
        return cellController.configured(with: pokemon)
    }

}
