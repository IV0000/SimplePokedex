//
//  PokemonModel.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import Foundation

struct Result: Codable {
    let next: String?
    let previous: String?
    let results: [Info]
    
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let moves: [Move]
    let species: Info // Pokedex description
    let sprites: Sprites
    let types: [TypeElement]
}

struct Move: Codable {
    let move: Info
}

struct Info: Codable, Hashable {
    let name: String
    let url: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Info
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
