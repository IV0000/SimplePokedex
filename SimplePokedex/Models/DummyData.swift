//
//  PreviewData.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 21/06/22.
//

import Foundation

let dummyPokemon1 = [
    Info(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
    Info(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
    Info(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
    Info(name: "mimikyu-busted", url: "https://pokeapi.co/api/v2/pokemon/10143/")
]

let defaultPokemon = Pokemon(id: 493, name: "arceus", moves: [Move](), species: Info(name: "arceus", url: "https://pokeapi.co/api/v2/pokemon-species/493/"), sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/493.png", backDefault: "", other: Other(officialArtwork: OfficialArtwork(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/493.png"))), types: [TypeElement]())
