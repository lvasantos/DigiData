//
//  SearchView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 23/10/22.
//

import UIKit

class SearchView: UIView {
    let searchListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
//        collection.backgroundColor = .blue
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchListView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        addGradientWithColor(color: .cyan)
        configSearchList()
    }

    func configSearchList() {
        NSLayoutConstraint.activate([
                searchListView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                searchListView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                searchListView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                searchListView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configListHeight() {

        searchListView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.4).isActive = true
    }
}
