//
//  DetailsViewModel.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 22/02/2024.
//

import Foundation

// MARK: - DetailsViewModelDelegate
protocol DetailsViewModelDelegate: AnyObject {

    func didLoadPokemonDetails()
}

// MARK: - DetailsViewModel
class DetailsViewModel {

    // MARK: - Attributes
    private let pokemonUrlString: String
    private var pokemonDetails: PokemonDetails?

    let dataSource = PokemonDataSource()
    weak var delegate: DetailsViewModelDelegate?

    // MARK: - Lifecycle
    init(pokemonUrlString: String) {

        self.pokemonUrlString = pokemonUrlString
    }

    // MARK: - Data
    func pokemonName() -> String {

        guard let pokemonDetails = self.pokemonDetails else { return "" }

        return pokemonDetails.name.capitalized
    }

    func pokemonImageUrl() -> URL? {

        guard let pokemonDetails = self.pokemonDetails else { return nil }

        do {

            return try self.dataSource.pokemonImageUrl(for: pokemonDetails.id)

        } catch {

            print(error.localizedDescription)
            return nil
        }
    }

    func pokemonId() -> String {

        guard let pokemonId = self.pokemonDetails?.id else { return "" }

        return "# \(pokemonId)"
    }

    func sizeTitle() -> String {

        return "Size:"
    }

    func pokemonSize() -> String {

        guard let pokemonDetails = self.pokemonDetails else { return "" }

        return "\(pokemonDetails.height * 10) cm | \(pokemonDetails.weight / 10) Kg"
    }

    func typesTitle() -> String {

        return "Types:"
    }

    func pokemonTypes() -> [String] {

        guard let pokemonDetails = self.pokemonDetails else { return [] }

        return pokemonDetails.types.map({ typeElement in

            return typeElement.type.name.capitalized
        })
    }

    func movesTitle() -> String {

        return "Moves:"
    }

    func pokemonMoves() -> [String] {

        guard let pokemonDetails = self.pokemonDetails else { return [] }

        /*
         * This will limit the moves displayed to a maxmum of 4
         */
        return pokemonDetails.moves.prefix(4).map { moveElement in

            return moveElement.move.name.capitalized
        }
    }

    // MARK: - Requests
    func loadPokemonDetails() {

        Task {

            do {

                self.pokemonDetails = try await self.dataSource.fetchPokemonDetails(for: self.pokemonUrlString)

                self.delegate?.didLoadPokemonDetails()

            } catch {

                print(error.localizedDescription)
            }
        }
    }
}
