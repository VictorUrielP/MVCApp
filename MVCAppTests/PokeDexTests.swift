//
//  PokeDexTests.swift
//  MVCAppTests
//

import XCTest
@testable import MVCApp

final class PokeDexTests: XCTestCase {

    func test_initWithBundle_loadsTheBundledJSON() {
        let sut = PokeDex(bundle: .main)

        XCTAssertFalse(sut.pokemons.isEmpty)
    }

    func test_everyBundledPokemon_hasAnImageAsset() {
        let pokemons = PokeDex(bundle: .main).pokemons

        let missing = pokemons.filter { UIImage(named: $0.image) == nil }.map(\.name)

        XCTAssertEqual(missing, [])
    }

    func test_initWithBundle_withoutJSON_isEmpty() {
        let sut = PokeDex(bundle: Bundle(for: PokeDexTests.self))

        XCTAssertTrue(sut.pokemons.isEmpty)
    }
}
