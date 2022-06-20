//
//  PokemonModel.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let moves: [Move]
    let species: Species // Pokedex description
    let sprites: Sprites
    let types: [TypeElement]
}

struct Move: Codable {
    let move: Species
}

struct Species: Codable {
    let name: String
    let url: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Species
}

struct Sprites: Codable {
    let frontDefault: String
    let other: Other
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
