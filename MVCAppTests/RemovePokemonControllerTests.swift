//
//  RemovePokemonControllerTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class RemovePokemonControllerTests: XCTestCase {

    func test_removeButtonPressed_removesTheSelectedPokemon() {
        let list = PokemonList(pokedex: makePokedex(ids: [1, 2, 3]))
        let sut = RemovePokemonController(pokemonList: list)
        sut.selectedIndex = { 1 }

        sut.removeButtonPressed()

        XCTAssertEqual(list.pokemons.map(\.id), [1, 3])
    }

    func test_removeButtonPressed_withoutSelection_removesNothing() {
        let list = PokemonList(pokedex: makePokedex(ids: [1, 2, 3]))
        let sut = RemovePokemonController(pokemonList: list)
        var didRemove = false
        sut.selectedIndex = { nil }
        sut.didRemovePokemon = { didRemove = true }

        sut.removeButtonPressed()

        XCTAssertEqual(list.pokemons.map(\.id), [1, 2, 3])
        XCTAssertFalse(didRemove)
    }

    func test_selectionDidChange_enablesTheButtonOnlyWithASelection() {
        let sut = RemovePokemonController(pokemonList: PokemonList(pokedex: makePokedex(ids: [1])))
        var selection: Int?
        sut.selectedIndex = { selection }

        sut.selectionDidChange()
        XCTAssertFalse(sut.barButtonItem.isEnabled)

        selection = 0
        sut.selectionDidChange()
        XCTAssertTrue(sut.barButtonItem.isEnabled)
    }
}
