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
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

// Pokemon description
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Info

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}
