//
//  PokemonCell.swift
//  pokedex-app
//
//  Created by Rodrigo Giglio on 21/02/2024.
//

import UIKit
import Kingfisher

// MARK: - PokemonCell
class PokemonCell: UITableViewCell {

    // MARK: - Views
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 55
        view.backgroundColor = .quaternaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 45
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func awakeFromNib() {

        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        // MARK: - Card
        self.addSubview(self.cardView)
        self.cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        self.cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        self.cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true

        // MARK: - Image
        self.cardView.addSubview(self.pokemonImageView)
        self.pokemonImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.pokemonImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        self.pokemonImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
        self.pokemonImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12).isActive = true

        // MARK: - Name and Id
        let informationStack = UIStackView()
        informationStack.axis = .vertical
        informationStack.translatesAutoresizingMaskIntoConstraints = false
        informationStack.alignment = .leading

        self.cardView.addSubview(informationStack)
        informationStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12).isActive = true
        informationStack.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 8).isActive = true
        informationStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true

        informationStack.addArrangedSubview(self.nameLabel)
        informationStack.addArrangedSubview(self.idLabel)
    }

    func configureData(name: String, id: String, imageUrl: URL?) {

        self.nameLabel.text = name
        self.idLabel.text = id
        self.pokemonImageView.kf.setImage(with: imageUrl, options: [.cacheOriginalImage])

    }

    required init?(coder: NSCoder) {

       fatalError("init(coder:) has not been implemented")
    }
}
