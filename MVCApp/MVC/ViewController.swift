//
//  ViewController.swift
//  MVCApp
//
//  Created by Jorge Benavides
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Stored Properties
    let pokedex = PokeDex()

    lazy var pokemons: [Pokemon] = Array(pokedex.pokemons.prefix(4))

    lazy var tableView = UITableView(frame: view.bounds, style: .plain)

    var selection: Int?

    // MARK: - Computed properties
    var numberOfItems: Int {
        pokemons.count
    }

    func primaryText(for index: Int) -> String {
        pokemons[index].name
    }

    func imageResource(for index: Int) -> String {
        pokemons[index].image
    }

    // MARK: Pokemon List Operations
    func addPokemon() {
        guard let next = pokedex.pokemons.first(where: { candidate in
            !pokemons.contains { $0.id == candidate.id }
        }) else {
            return
        }
        pokemons.append(next)
    }

    func removePokemon(at index: Int) {
        pokemons.remove(at: index)
    }

    // MARK: TableView Operations
    func tableViewDidSelectRow(at index: Int) {
        selection = index
    }

    func scrollToBottom() {
        guard numberOfItems > 0 else { return }
        let indexPath = IndexPath(row: numberOfItems - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func tableViewDidSelectAdd() {
        addPokemon()
        tableView.reloadData()
        scrollToBottom()
        selection = nil
    }

    func tableViewDidSelectRemove() {
        guard let selection = selection else { return }
        removePokemon(at: selection)
        tableView.reloadData()
        self.selection = nil
    }

    // MARK: - Life cycle callbacks
    override func viewDidLoad() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - User actions
    @objc func removeButtonPressed() {
        tableViewDidSelectRemove()
    }

    @objc func addButtonPressed() {
        tableViewDidSelectAdd()
    }

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = primaryText(for: indexPath.row)
        config.image = UIImage(named: imageResource(for: indexPath.row))
        config.imageProperties.maximumSize = .init(width: 80, height: 80)
        cell.contentConfiguration = config
        return cell
    }

}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIButton.systemButton(with: .remove, target: self, action: #selector(removeButtonPressed))
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIButton.systemButton(with: .add, target: self, action: #selector(addButtonPressed))
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
