//
//  PokemonListTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class PokemonListTests: XCTestCase {

    func test_pokemons_startsWithTheFirstFourEntries() {
        let sut = PokemonList(pokedex: makePokedex(ids: [1, 2, 3, 4, 5, 6]))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2, 3, 4])
    }

    func test_pokemons_withFewerThanFourEntries_startsWithAllOfThem() {
        let sut = PokemonList(pokedex: makePokedex(ids: [1, 2]))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2])
    }

    func test_pokemons_withEmptyPokedex_isEmpty() {
        let sut = PokemonList(pokedex: makePokedex(ids: []))

        XCTAssertTrue(sut.pokemons.isEmpty)
    }

    func test_append_addsToTheEnd() {
        let sut = PokemonList(pokedex: makePokedex(ids: [1, 2]))

        sut.append(makePokemon(id: 9))

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 2, 9])
    }

    func test_remove_removesTheEntryAtIndex() {
        let sut = PokemonList(pokedex: makePokedex(ids: [1, 2, 3]))

        sut.remove(at: 1)

        XCTAssertEqual(sut.pokemons.map(\.id), [1, 3])
    }
}
