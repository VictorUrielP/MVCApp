//
//  PokemonAggregatorTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class PokemonAggregatorTests: XCTestCase {

    func test_addPokemon_returnsTheFirstEntryNotListed() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.addPokemon(pokemons: [makePokemon(id: 1)])

        XCTAssertEqual(next?.id, 2)
    }

    func test_addPokemon_withEmptyList_returnsTheFirstEntry() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.addPokemon(pokemons: [])

        XCTAssertEqual(next?.id, 1)
    }

    func test_addPokemon_returnsAPreviouslyRemovedEntry() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.addPokemon(pokemons: [makePokemon(id: 1), makePokemon(id: 3)])

        XCTAssertEqual(next?.id, 2)
    }

    func test_addPokemon_whenEveryEntryIsListed_returnsNil() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2]))

        let next = sut.addPokemon(pokemons: [makePokemon(id: 1), makePokemon(id: 2)])

        XCTAssertNil(next)
    }
}
