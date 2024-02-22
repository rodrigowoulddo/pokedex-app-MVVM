//
//  PokemonDataSource.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import Foundation

class PokemonDataSource {

    // MARK: Constants
    private enum Constants {

        static let baseUrl: String = "https://pokeapi.co/api/v2/pokemon"
        static let imageBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon"
    }

    // MARK: - Requests
    func fetchPokemonListing() async throws -> [PokemonResource] {


        var urlComponents = URLComponents(string: Constants.baseUrl)

        /*
         * This will limit the listing to the 151
         * Pokémon from the first generation.
         */
        let queryItems = [URLQueryItem(name: "limit", value: "151")]

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else { throw PokemonDataSourceError.invalidPokemonApiUrl }

        let urlRequest = URLRequest(url: url)

        do {

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard response.hasSucceded else {

                throw PokemonDataSourceError.invalidPokemonApiResponse
            }

            let pokemonResponse = try JSONDecoder().decode(PokemonResourceResponse.self, from: data)

            return pokemonResponse.results

        } catch {

            throw PokemonDataSourceError.invalidPokemonListingData
        }
    }

    func fetchPokemonDetails(for urlString: String) async throws -> PokemonDetails {

        guard let url = URL(string: urlString) else { throw PokemonDataSourceError.invalidPokemonApiUrl }

        let urlRequest = URLRequest(url: url)

        do {

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard response.hasSucceded else {

                throw PokemonDataSourceError.invalidPokemonApiResponse
            }

            let pokemonDetails = try JSONDecoder().decode(PokemonDetails.self, from: data)

            return pokemonDetails

        } catch {

            throw PokemonDataSourceError.invalidPokemonDetailsData
        }
    }

    // MARK: - Image
    func pokemonImageUrl(for id: Int) throws -> URL {

        let urlString = "\(Constants.imageBaseUrl)/\(id).png"

        guard let url = URL(string: urlString) else { throw PokemonDataSourceError.invalidPokemonImageUrl }

        return url
    }
}

// MARK: - PokemonDataSourceError
enum PokemonDataSourceError: Error {

    case invalidPokemonApiUrl
    case invalidPokemonImageUrl
    case invalidPokemonListingData
    case invalidPokemonDetailsData
    case invalidPokemonApiResponse
}
