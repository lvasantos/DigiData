//
//  TabBarViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    let vc1 = DigimonListViewController()
    let vc2 = SearchViewController()
    let vc3 = FavoriteViewController()
    let vc4 = DigimonCardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Favorite"

        vc4.title = "Testing"

        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always

        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .systemBackground

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)

        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Teste", image: UIImage(systemName: "questionmark"), tag: 1)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true

        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
}
