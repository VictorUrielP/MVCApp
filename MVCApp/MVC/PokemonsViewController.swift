//
//  ViewController.swift
//  MVCApp
//
//  Created by Jorge Benavides
//

import UIKit

final class PokemonsViewController: UIViewController {

    // MARK: - Stored Properties
    private let pokemonList: PokemonList
    private var addPokemonController: AddPokemonController
    private var removePokemonController: RemovePokemonController
    private lazy var tableView = UITableView(frame: view.bounds, style: .plain)

    // MARK: - Life cycle callbacks
    override func viewDidLoad() {
        super.viewDidLoad()
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
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonCellController.self, forCellReuseIdentifier: "PokemonCellController")
    }
    
    private func bind() {
        addPokemonController.didAddPokemon = { [weak self] in
            self?.tableViewDidSelectAdd()
        }
        removePokemonController.didRemovePokemon = { [weak self] in
            self?.tableViewDidSelectRemove()
        }
    }
    
    // MARK: TableView Operations
    private func tableViewDidSelectRow(at index: Int) {
        removePokemonController.pokemonToRemove(index)
    }

    private func tableViewDidSelectAdd() {
        tableView.reloadData()
        removePokemonController.pokemonToRemove(nil)
        scrollToBottom()
    }

    private func tableViewDidSelectRemove() {
        tableView.reloadData()
    }
    
    private func scrollToBottom() {
        guard pokemonList.numberOfItems > 0 else { return }
        let lastIndexPath = IndexPath(row: pokemonList.numberOfItems - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PokemonsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonList.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellController = tableView.dequeueReusableCell(withIdentifier: "PokemonCellController", for: indexPath) as? PokemonCellController else { return UITableViewCell() }
        let pokemon = pokemonList.pokemon(at: indexPath.row)
        return cellController.configured(with: pokemon)
    }

}

// MARK: - UITableViewDelegate
extension PokemonsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        removePokemonController.view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        addPokemonController.view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDidSelectRow(at: indexPath.row)
    }

}
