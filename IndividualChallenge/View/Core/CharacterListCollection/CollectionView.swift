//
//  DataView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 19/10/22.
//

import UIKit

class CollectionView: UIView {

    let charLabel: UILabel = {
        let label = UILabel()
        label.text = "Character List"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let charlistView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let favoriteListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .black
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(charLabel)
        addSubview(favoriteLabel)
        addSubview(charlistView)
        addSubview(favoriteListView)

        self.setConstraints()
        self.configListHeight()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addGradientWithColor(color: .white.withAlphaComponent(0.05))
    }

    func configListHeight() {
        charlistView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1875).isActive     = true
        favoriteListView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.45).isActive = true
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            self.charLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.charLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.charLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.charLabel.bottomAnchor.constraint(equalTo: self.charlistView.topAnchor),

            self.charlistView.leadingAnchor.constraint(equalTo: charLabel.leadingAnchor),
            self.charlistView.trailingAnchor.constraint(equalTo: charLabel.trailingAnchor),

            self.favoriteLabel.topAnchor.constraint(equalTo: charlistView.bottomAnchor),
            self.favoriteLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            self.favoriteLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            self.favoriteLabel.bottomAnchor.constraint(equalTo: self.favoriteListView.topAnchor),

            self.favoriteListView.leadingAnchor.constraint(equalTo: favoriteLabel.leadingAnchor),
            self.favoriteListView.trailingAnchor.constraint(equalTo: favoriteLabel.trailingAnchor)
        ])
    }
}
