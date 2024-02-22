//
//  DetailsView.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 22/02/2024.
//

import UIKit

// MARK: - DetailsView
class DetailsView: UIViewController {

    // MARK: - Attributes
    let viewModel: DetailsViewModel

    // MARK: - Views
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator =  UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 125
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .quaternaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var typestackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    private lazy var movesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Lifecycle
    init(viewModel: DetailsViewModel) {
        
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.viewModel.delegate = self

        self.setUpActivityIndicator()

        self.viewModel.loadPokemonDetails()
    }
}

// MARK: - Private
private extension DetailsView {

    func setUpActivityIndicator() {

        self.view.addSubview(self.activityIndicator)

        self.activityIndicator.startAnimating()

        self.activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    func removeActvityIndicator() {

        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }

    func setupViews() {

        self.removeActvityIndicator()
        self.title = self.viewModel.pokemonName()

        // MARK: - Main Stack View
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8

        self.view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 12).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -12).isActive = true

        // MARK: - Image
        stackView.addArrangedSubview(self.imageView)
        self.imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.imageView.kf.setImage(with: self.viewModel.pokemonImageUrl(), options: [.cacheOriginalImage])

        // MARK: - Id
        stackView.addArrangedSubview(self.idLabel)
        self.idLabel.text = self.viewModel.pokemonId()

        // MARK: - Size
        let sizeTitle = self.viewModel.sizeTitle()
        stackView.addArrangedSubview(self.titleLabel(for: sizeTitle))
        stackView.addArrangedSubview(self.sizeLabel)
        self.sizeLabel.text = self.viewModel.pokemonSize()

        // MARK: - Types
        let typesTitle = self.viewModel.typesTitle()
        stackView.addArrangedSubview(self.titleLabel(for: typesTitle))
        stackView.addArrangedSubview(self.typestackView)
        for typeName in self.viewModel.pokemonTypes() {

            let typeLabel = UILabel()
            typeLabel.text = typeName
            typeLabel.backgroundColor = .lightGray
            self.typestackView.addArrangedSubview(typeLabel)
        }

        // MARK: - Moves
        let movesTitle = self.viewModel.movesTitle()
        stackView.addArrangedSubview(self.titleLabel(for: movesTitle))
        stackView.addArrangedSubview(self.movesStackView)
        for moveName in self.viewModel.pokemonMoves() {

            let moveLabel = UILabel()
            moveLabel.text = moveName
            self.movesStackView.addArrangedSubview(moveLabel)
        }
    }

    func titleLabel(for text: String) -> UILabel {

        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - DetailsViewModelDelegate
extension DetailsView: DetailsViewModelDelegate {
    
    func didLoadPokemonDetails() {

        DispatchQueue.main.async {

            self.setupViews()
        }
    }
}
