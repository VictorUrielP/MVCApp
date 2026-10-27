//
//  PokemonCell.swift
//  MVCApp
//
//  Created by Victor Pacheco on 28/10/22.
//

import UIKit

final class PokemonCell: UITableViewCell {
    static let reuseIdentifier = "PokemonCell"
    private static let maximumImageSize = CGSize(width: 80, height: 80)

    func configure(with pokemon: Pokemon) {
        var config = defaultContentConfiguration()
        config.text = pokemon.name
        config.image = UIImage(named: pokemon.image)
        config.imageProperties.maximumSize = Self.maximumImageSize
        contentConfiguration = config
    }
}
