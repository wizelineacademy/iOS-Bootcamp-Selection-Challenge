//
//  ItemView.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

struct Item {
    let title: String
    let description: String
}


class ItemView: UIView {

    private let item: Item
    private let margin: CGFloat = 20

    private lazy var width: CGFloat = {
        UIScreen.main.bounds.width / 2 - margin * 3.5
    }()

    lazy
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = margin
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init(item: Item) {
        self.item = item
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }

    private func setupUI() {
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

}
