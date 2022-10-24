//
//  SearchViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {


    let searchView = SearchView()
    let controller = UISearchController()
    var debounceTimer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(color: .systemCyan)
        controller.searchResultsUpdater = self
        view.addSubview(searchView)

        // 🚧 Trabalhando nisso. N mexa.
        navigationItem.searchController = controller

    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {return}
        let viewModel = DigimonViewModel()
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            Task {
                if let input = Int(query) {
                    let res = await viewModel.searchDigimonByID(Int(query)!)
                    print(res.name)
                }
            }
        })
    }
}
