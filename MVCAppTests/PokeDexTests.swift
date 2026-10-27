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

    func test_initWithBundle_withoutJSON_isEmpty() {
        let sut = PokeDex(bundle: Bundle(for: PokeDexTests.self))

        XCTAssertTrue(sut.pokemons.isEmpty)
    }
}
