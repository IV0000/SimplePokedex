//
//  SpecieInfoModel.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 22/06/22.
//

import Foundation

// Model to decode pokemon-species
struct SpeciesInfo: Codable {
    let flavorTextEntries: [FlavorTextEntry]
    let pokedexNumbers: [PokedexNumber]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case pokedexNumbers = "pokedex_numbers"
    }
}

// Pokemon description
struct FlavorTextEntry: Codable, Hashable {
    let flavorText: String
    let language: Info

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

struct PokedexNumber: Codable {
    let entryNumber: Int

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
    }
}
