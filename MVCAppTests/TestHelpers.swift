//
//  TestHelpers.swift
//  MVCAppTests
//

@testable import MVCApp

func makePokemon(id: Int) -> Pokemon {
    Pokemon(id: id,
            name: "pokemon-\(id)",
            image: "p.pokemon-\(id)",
            weight: 1,
            base_experience: 1,
            types: [],
            abilities: [])
}

func makePokedex(ids: [Int]) -> PokeDex {
    PokeDex(pokemons: ids.map(makePokemon(id:)))
}
