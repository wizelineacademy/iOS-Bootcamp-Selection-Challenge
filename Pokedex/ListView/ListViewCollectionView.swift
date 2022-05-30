//
//  ListViewCollectionView.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class ListViewCollectionView: UICollectionView {

    let viewModel: ListViewModelProtocol

    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel

        super.init(frame: .zero, collectionViewLayout: ListViewCollectionViewLayout())

        // Set up the collection view.
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = .white
        self.alwaysBounceVertical = true
        self.indicatorStyle = .white

        // delegate and datasource assign to it self to delegate to viewModel
        self.delegate = self
        self.dataSource = self

        // register the cell
        self.register(PokeCell.self, forCellWithReuseIdentifier: PokeCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("coder init not implemented")
    }

    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl?.endRefreshing()
            self?.reloadData()
        }
    }

    lazy
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        return activityIndicator
    }()

}

extension ListViewCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPokeCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell
        else { preconditionFailure("Failed to load collection view cell") }
        cell.pokemon = viewModel.pokemon(at: indexPath.item)
        return cell
    }

}

extension ListViewCollectionView: UICollectionViewDelegate {

    // TODO: Handle navigation to detail view controller

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
