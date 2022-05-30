//
//  CardView.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

struct Card {
    let title: String
    let items: [Item]
}

class CardView: UIView {

    private let card: Card
    private let margin: CGFloat = 30

    lazy
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        titleLabel.text = card.title
        backgroundColor = .white
        layer.cornerRadius = 20
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: margin * 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true

        // TODO: Display pokemon info (eg. types, abilities)

    }

}
