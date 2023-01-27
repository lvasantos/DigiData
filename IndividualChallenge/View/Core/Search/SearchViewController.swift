//
//  SearchViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit

class SearchViewController: UIViewController {
    let searchView = SearchView()
    let viewModel = DigimonViewModel()
    let vModel = SearchViewModel()
    let controller = UISearchController()
    var debounceTimer: Timer?
//    var digiData = Set<String>()
    var digiData: [String] = []
    var digiDataSet =  Set<String>()

    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.searchResultsUpdater = self
        self.searchView.searchListView.delegate = self
        self.searchView.searchListView.dataSource = self
        navigationItem.searchController = controller

    }
}

// MARK: Extensions

extension SearchViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        digiData.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
                        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterListCell", for: indexPath)
        let url = digiData[indexPath.row]
        guard let charCell = cell as? CollectionViewCell else { return UICollectionViewCell() }
        charCell.configure(digiData: url)
        return charCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let mult = 0.4
        return CGSize(
            width: collectionView.frame.width * mult,
            height: collectionView.frame.width * mult
        )
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        let viewModel = DigimonViewModel()
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in

            Task {
                if query.isEmpty {
                    self.digiData = []
//                    self.digiData.removeAll()
                    DispatchQueue.main.async {
                        self.searchView.searchListView.reloadData()
                    }
                }
                if query.isNumber {
                    if let input = Int(query) {
                        let res = await viewModel.searchDigimonByID(input)
//                        self.digiData.append("https://www.digimon-api.com/api/v1/digimon/\(res.id)")
                        let link = "https://www.digimon-api.com/api/v1/digimon/\(res.id)"
                        if self.digiData.isEmpty {
                            self.digiData.append(link)
                        } else {
                            let filteredArray = self.digiData.filter { element in
                                if element == link {
                                    return false
                                } else {
                                    self.digiData.append(link)
                                }
                                return false
                            }
                        }
                        DispatchQueue.main.async {
                            self.searchView.searchListView.reloadData()
                        }
                    }
                } else {
                    let res = await viewModel.searchDigimonByName(query)
                    print("string: \(res.name)")
                }
            }

        })
    }
}
