//
//  PokemonModel.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 20/06/22.
//

import Foundation

struct FetchResult: Codable {
    let next: String?
    let previous: String?
    let results: [Info]
    
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let moves: [Move]
    let species: Info // Pokedex description
    let sprites: Sprites?
    let types: [TypeElement]
}

struct Move: Codable, Hashable {
    let move: Info
}

// This couple name / url is reccurent in the API || Need to find a better name
struct Info: Codable, Hashable, Comparable {
   
    let name: String
    let url: String
    
    //Comparable stubs
    static func < (lhs: Info, rhs: Info) -> Bool {
        return lhs.name < rhs.name
    }
}

struct TypeElement: Codable, Hashable {
    let slot: Int
    let type: Info
}

struct Sprites: Codable {
    let frontDefault: String?
    let backDefault: String?
    let other: Other?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case other
    }
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
