//
//  PokemonAggregatorTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class PokemonAggregatorTests: XCTestCase {

    func test_nextPokemon_returnsTheFirstEntryNotListed() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.nextPokemon(notIn: [makePokemon(id: 1)])

        XCTAssertEqual(next?.id, 2)
    }

    func test_nextPokemon_withEmptyList_returnsTheFirstEntry() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.nextPokemon(notIn: [])

        XCTAssertEqual(next?.id, 1)
    }

    func test_nextPokemon_returnsAPreviouslyRemovedEntry() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2, 3]))

        let next = sut.nextPokemon(notIn: [makePokemon(id: 1), makePokemon(id: 3)])

        XCTAssertEqual(next?.id, 2)
    }

    func test_nextPokemon_whenEveryEntryIsListed_returnsNil() {
        let sut = PokemonAggregator(pokedex: makePokedex(ids: [1, 2]))

        let next = sut.nextPokemon(notIn: [makePokemon(id: 1), makePokemon(id: 2)])

        XCTAssertNil(next)
    }
}
