//
//  PokemonsViewController.swift
//  MVCApp
//
//  Created by Jorge Benavides
//

import UIKit

final class PokemonsViewController: UIViewController {

    // MARK: - Stored Properties
    private let pokemonList: PokemonList
    private let addPokemonController: AddPokemonController
    private let removePokemonController: RemovePokemonController
    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Life cycle callbacks
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTableView()
        bind()
    }
    
    init(pokemonList: PokemonList,
         addPokemonController: AddPokemonController,
         removePokemonController: RemovePokemonController) {
        self.pokemonList = pokemonList
        self.addPokemonController = addPokemonController
        self.removePokemonController = removePokemonController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Initial setup
    private func configureNavigationItem() {
        title = "Pokédex"
        navigationItem.leftBarButtonItem = removePokemonController.barButtonItem
        navigationItem.rightBarButtonItem = addPokemonController.barButtonItem
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
    }
    
    private func bind() {
        addPokemonController.didAddPokemon = { [weak self] in
            self?.pokemonWasAdded()
        }
        removePokemonController.didRemovePokemon = { [weak self] index in
            self?.pokemonWasRemoved(at: index)
        }
        removePokemonController.selectedIndex = { [weak self] in
            self?.tableView.indexPathForSelectedRow?.row
        }
        removePokemonController.selectionDidChange()
    }
    
    // MARK: TableView Operations
    private func pokemonWasAdded() {
        let lastIndexPath = IndexPath(row: pokemonList.numberOfItems - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        removePokemonController.selectionDidChange()
    }

    private func pokemonWasRemoved(at index: Int) {
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        removePokemonController.selectionDidChange()
    }
}

// MARK: - UITableViewDataSource
extension PokemonsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonList.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell else {
            fatalError("Expected a PokemonCell for \(PokemonCell.reuseIdentifier); is the cell registered?")
        }
        cell.configure(with: pokemonList.pokemon(at: indexPath.row))
        return cell
    }

}

// MARK: - UITableViewDelegate
extension PokemonsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removePokemonController.selectionDidChange()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        removePokemonController.selectionDidChange()
    }

}
