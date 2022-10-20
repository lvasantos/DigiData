//
//  DataView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 19/10/22.
//

import UIKit

class CharacterListCollectionView: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Character List"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CharacterListViewCell.self, forCellWithReuseIdentifier: CharacterListViewCell.identifier)
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.backgroundColor = .clear
        addSubview(label)
        addSubview(collectionView)
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),

            self.collectionView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.125)
        ])
    }
}
