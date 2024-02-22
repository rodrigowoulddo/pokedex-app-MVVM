//
//  PokemonDetails.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import Foundation

// MARK: - PokemonDetails
struct PokemonDetails: Codable {

    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let types: [TypeElement]
    let weight: Int
}

// MARK: - Move
struct Move: Codable {

    let move: Species

    enum CodingKeys: String, CodingKey {
        case move
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {

    let slot: Int
    let type: Species
}

// MARK: - Species
struct Species: Codable {

    let name: String
    let url: String
}
