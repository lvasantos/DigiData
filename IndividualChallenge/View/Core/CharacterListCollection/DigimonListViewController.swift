//
//  HomeViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit
import Foundation

class DigimonListViewController: UIViewController {
    var digiData: [String] = [] {
        didSet {
            //TODO: reload data collection
        }
    }
    var array: [String] = []

    let collectionView: CharacterListCollectionView = CharacterListCollectionView()
    let viewModel: CharacterListViewModel = CharacterListViewModel()

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(color: .magenta)
        self.collectionView.collectionView.delegate = self
        self.collectionView.collectionView.dataSource = self

        //TODO: Carregar dados da api <- VIEW MODEL QUE FAZ ISSO
        //TODO: atualizar digiData
        //TODO: reload data na collection OU LA NO DID SET NÃO NOS 2 AO MSM TEMPO

        viewModel.getPageLink { links in
            self.digiData = links
            DispatchQueue.main.async {
                self.collectionView.collectionView.reloadData()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension DigimonListViewController:
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterListViewCell.identifier,
            for: indexPath)
//
//        let cellInformation = digiData[indexPath.row]
//        guard let url = cellInformation.images.first?.href, let charCell = cell as? CharacterListViewCell else {
//            return UICollectionViewCell()
//        }
//        charCell.configure(digiData: url)

        let url = digiData[indexPath.row]
        guard let charCell = cell as? CharacterListViewCell else {
            return UICollectionViewCell()
        }
        charCell.configure(digiData: url)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return digiData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
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
        return CGSize(width: collectionView.frame.height * 0.9, height: collectionView.frame.height * 0.9)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected\(indexPath.section) and row \(indexPath.row)")
    }
}
