//
//  DetailView.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

struct DetailView: ViewProtocol {

    var viewModel: DetailViewModelProtocol

    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body = UIView()

    func didLoad(on viewController: UIViewController) {
        body.backgroundColor = .lightGray

        let topAnchor: NSLayoutYAxisAnchor
        if viewController.navigationController == nil {
            let navigationView = self.navigationView()
            body.addSubview(navigationView)
            navigationView.topAnchor.constraint(equalTo: body.topAnchor).isActive = true
            navigationView.leftAnchor.constraint(equalTo: body.leftAnchor).isActive = true
            topAnchor = navigationView.bottomAnchor
        } else {
            topAnchor = viewController.view.safeAreaLayoutGuide.topAnchor
        }

        let typesStackView = typesStackView()
        body.addSubview(typesStackView)
        typesStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        typesStackView.leftAnchor.constraint(equalTo: body.leftAnchor, constant: margin).isActive = true
        typesStackView.widthAnchor.constraint(lessThanOrEqualTo: body.widthAnchor, multiplier: 0.7).isActive = true

        let idLabel = idLabel()
        body.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: typesStackView.topAnchor).isActive = true
        idLabel.rightAnchor.constraint(equalTo: body.rightAnchor, constant: -margin).isActive = true

        let cardView = cardView()
        body.addSubview(cardView)
        cardView.heightAnchor.constraint(equalTo: body.heightAnchor, multiplier: 0.6).isActive = true
        cardView.leftAnchor.constraint(equalTo: body.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: body.rightAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: body.bottomAnchor).isActive = true

        let imageView = imageView()
        body.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: cardView.topAnchor, constant: -margin).isActive = true
        imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func layout() {
        body.addGradient(colors: PokemonColor.gradientColors(for: viewModel.pokemonTypes.first))
    }

    func willAppear(on viewController: UIViewController, animated: Bool) {
        let tintColor: UIColor = .white
        let backgroundColor: UIColor = .clear
        let foregroundColor: UIColor = .white
        
        // customize navigation bar.
        let navigationBar = viewController.navigationController?.navigationBar
        navigationBar?.tintColor = tintColor
        navigationBar?.prefersLargeTitles = true
        navigationBar?.standardAppearance.backgroundColor = backgroundColor
        navigationBar?.standardAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navigationBar?.standardAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]

        navigationBar?.scrollEdgeAppearance = navigationBar?.standardAppearance
        navigationBar?.scrollEdgeAppearance?.configureWithTransparentBackground()
        
        // set current view controller's title
        viewController.title = viewModel.title
    }

    private let margin: CGFloat = 20

    private func navigationView() -> UIView {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(viewModel.dismissHandler, for: .touchUpInside)
        
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonName

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = margin
        stack.distribution = .equalSpacing
        stack.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(label)
        return stack
    }

    private func idLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonID
        return label
    }

    private func typesStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = margin/2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.zPosition = 2
        for type in viewModel.pokemonTypes {
            let padding = 20.0
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = type.capitalized
            label.backgroundColor = .white.withAlphaComponent(0.30)
            label.layer.cornerRadius = 7.0
            label.layer.masksToBounds = true
            let paddedWidth = label.intrinsicContentSize.width + padding
            label.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            stackView.addArrangedSubview(label)
        }
        return stackView
    }

    private func imageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        if let image = viewModel.pokemonImageURL {
            view.setImage(with: image, cachePolicy: .returnCacheDataElseLoad)
        }
        return view
    }

    private func cardView() -> CardView {
        let title = "About"
        let cardView = CardView(card: Card(title: title, items: items()))
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }

    private func items() -> [Item] {
        var items = [Item]()

        // abilities
        let abilities = viewModel.pokemonAbilities

        if abilities.count > 0 {
            let title = "Abilities"
            let description = abilities.joined(separator: "\n")
            let item = Item(title: title, description: description)
            items.append(item)
        }

        // weight
        let weight = "Weight"
        items.append(Item(title: weight, description: viewModel.pokemonWeight))

        // baseExperience
        let baseExperience = "Base Experience"
        items.append(Item(title: baseExperience, description: viewModel.pokemonExperience))

        return items
    }

}
