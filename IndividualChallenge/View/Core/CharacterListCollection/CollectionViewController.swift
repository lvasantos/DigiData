//
//  HomeViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit
import Foundation

protocol CollectionViewControllerDelegate: AnyObject {
    func doSomething(using url: String)
}

class CollectionViewController: UIViewController {

    let listOfCollections: CollectionView = CollectionView()
    let viewModel: ListViewModel = ListViewModel()
    weak var delegate: CollectionViewControllerDelegate?

    private var digiData: [String] = []
    var favorites: [String] = ["https://digimon-api.com/api/v1/digimon/Palmon",
                               "https://digimon-api.com/api/v1/digimon/Impmon",
                               "https://digimon-api.com/api/v1/digimon/Lopmon",
                               "https://digimon-api.com/api/v1/digimon/Dianamon",
                               "https://digimon-api.com/api/v1/digimon/Dogmon"]

    override func loadView() {
        view = listOfCollections
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listOfCollections.charlistView.delegate = self
        self.listOfCollections.charlistView.dataSource = self
        self.listOfCollections.favoriteListView.delegate = self
        self.listOfCollections.favoriteListView.dataSource = self

        viewModel.getPageLink { links in
            self.digiData = links
            DispatchQueue.main.async {
                self.listOfCollections.charlistView.reloadData()
                self.listOfCollections.favoriteListView.reloadData()
            }
        }
    }
}

extension CollectionViewController:
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UICollectionViewDelegate {

    // MARK: Character List
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.listOfCollections.charlistView {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCell.identifier,
                for: indexPath)

            let url = digiData[indexPath.row]
            guard let charCell = cell as? CollectionViewCell else { return UICollectionViewCell() }
            charCell.configure(digiData: url)
            return charCell

        } else if collectionView == self.listOfCollections.favoriteListView {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCell.identifier,
                for: indexPath)

            let url = favorites[indexPath.row]
            guard let favoriteCell = cell as? CollectionViewCell else { return UICollectionViewCell() }
            favoriteCell.configure(digiData: url)
            return favoriteCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.listOfCollections.charlistView {
            return digiData.count
        } else if collectionView == self.listOfCollections.favoriteListView {
            return favorites.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.height * 0.9,
            height: collectionView.frame.height * 0.9
        )
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == self.listOfCollections.charlistView {
            delegate?.doSomething(using: self.digiData[indexPath.row])
        } else if collectionView == self.listOfCollections.favoriteListView {
            delegate?.doSomething(using: self.favorites[indexPath.row])
        }
    }
}
