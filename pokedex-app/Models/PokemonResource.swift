//
//  PokemonResource.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import Foundation

// MARK: - PokemonResourceResponse
struct PokemonResourceResponse: Codable {

    let count: Int
    let results: [PokemonResource]
}

// MARK: - PokemonResource
struct PokemonResource: Codable {

    let name: String
    let url: String

    var id: Int {

        /*
         * This will assume the Pokémon id from the
         * resource's URL. By doing this we avoid
         * making Pokémon details requests just to
         * get the id.
         */

        var urlNumbers = url.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        urlNumbers.remove(at: urlNumbers.startIndex)

        return Int(urlNumbers) ?? 0
    }
}
