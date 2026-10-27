//
//  PokemonsViewModelTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class PokemonsViewModelTests: XCTestCase {

    func test_pokemons_startsWithTheFirstFourEntries() {
        let sut = PokemonsViewModel(pokedex: makePokedex(ids: [1, 2, 3, 4, 5, 6]))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2, 3, 4])
    }

    func test_pokemons_withFewerThanFourEntries_startsWithAllOfThem() {
        let sut = PokemonsViewModel(pokedex: makePokedex(ids: [1, 2]))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2])
    }

    func test_pokemons_withEmptyPokedex_isEmpty() {
        let sut = PokemonsViewModel(pokedex: makePokedex(ids: []))

        XCTAssertTrue(sut.pokemons.isEmpty)
    }

    func test_addPokemon_appendsToTheEnd() {
        let sut = PokemonsViewModel(pokedex: makePokedex(ids: [1, 2]))

        sut.addPokemon(pokemon: makePokemon(id: 9))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2, 9])
    }

    func test_removePokemon_removesTheEntryAtIndex() {
        let sut = PokemonsViewModel(pokedex: makePokedex(ids: [1, 2, 3]))

        sut.removePokemon(at: 1)

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 3])
    }
}
