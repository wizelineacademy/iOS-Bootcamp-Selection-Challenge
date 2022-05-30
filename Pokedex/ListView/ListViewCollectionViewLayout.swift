//
//  ListViewCollectionViewLayout.swift
//  Pokedex
//
//  Created by Jorge Benavides
//

import UIKit

class ListViewCollectionViewLayout: UICollectionViewFlowLayout {

    private let preferedSize: CGSize = .init(width: 140, height: 100)
    private let preferedSpacing: CGFloat = 4

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        minimumInteritemSpacing = preferedSpacing

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / preferedSize.width)
        let cellWidth = floor(availableWidth / CGFloat(maxNumColumns))

        itemSize = CGSize(width: cellWidth, height: preferedSize.height)
        sectionInset = UIEdgeInsets(top: preferedSpacing * 2,
                                    left: preferedSpacing,
                                    bottom: preferedSpacing,
                                    right: preferedSpacing)
        sectionInsetReference = .fromSafeArea
    }
}
