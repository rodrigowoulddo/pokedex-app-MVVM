//
//  ListingViewModel.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import Foundation

// MARK: - ListingViewModelDelegate
protocol ListingViewModelDelegate: AnyObject {

    func didFetchPokemonListing()
}

// MARK: - ListingViewModel
class ListingViewModel {

    // MARK: - Attributes
    let dataSource = PokemonDataSource()

    var pokemonResources: [PokemonResource] = []

    weak var delegate: ListingViewModelDelegate?

    // MARK: - Data
    func listingTitle() -> String {

        return "Pokédex"
    }

    func pokemonListCount() -> Int {

        return pokemonResources.count
    }

    func nameForPokemon(at row: Int) -> String {

        return pokemonResources[row].name.capitalized
    }

    func idForPokemon(at row: Int) -> String {

        return "# \(pokemonResources[row].id)"
    }

    func imageUrlForPokemon(at row: Int) -> URL? {

        let pokemonResource = pokemonResources[row]

        do {

            return try self.dataSource.pokemonImageUrl(for: pokemonResource.id)

        } catch {

            print(error.localizedDescription)
            return nil
        }
    }

    func urlStringForPokrmon(at row: Int) -> String {

        return pokemonResources[row].url
    }


    // MARK: - Requests
    func loadPokemonResources() {

        Task {

            do {

                self.pokemonResources = try await self.dataSource.fetchPokemonListing()

                self.delegate?.didFetchPokemonListing()

            } catch {

                print(error.localizedDescription)
            }
        }
    }
}
