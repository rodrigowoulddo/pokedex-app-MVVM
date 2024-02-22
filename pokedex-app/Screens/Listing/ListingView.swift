//
//  ListingView.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import UIKit

// MARK: - ListingView
class ListingView: UIViewController {

    // MARK: Constants
    private enum Constants {

        static let reuseIdentifier: String = "reuseIdentifier"
    }

    // MARK: - Attributes
    let viewModel = ListingViewModel()

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.listingTitle()
        self.navigationItem.largeTitleDisplayMode = .always

        self.viewModel.delegate = self

        self.setupTableView()

        self.viewModel.loadPokemonResources()
    }
}

// MARK: - Private
private extension ListingView {

    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(PokemonCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)

        self.tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension ListingView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }

        cell.configureData(name: self.viewModel.nameForPokemon(at: indexPath.row),
                           id: self.viewModel.idForPokemon(at: indexPath.row),
                           imageUrl: self.viewModel.imageUrlForPokemon(at: indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        self.viewModel.pokemonListCount()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 140
    }
}

extension ListingView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let pokemonUrlString = self.viewModel.urlStringForPokrmon(at: indexPath.row)
        let viewModel = DetailsViewModel(pokemonUrlString: pokemonUrlString)
        let view = DetailsView(viewModel: viewModel)

        self.navigationController?.pushViewController(view, animated: true)
    }
}


// MARK: - ListingViewModelDelegate
extension ListingView: ListingViewModelDelegate {
   
    func didFetchPokemonListing() {

        DispatchQueue.main.async {

            self.tableView.reloadData()
        }
    }
}

