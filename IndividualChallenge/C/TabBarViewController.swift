//
//  TabBarViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    let vc1 = CollectionViewController()
    let vc2 = SearchViewController()
    let vc3 = DigimonCardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        vc1.title = "Welcome to digiData !"
        vc2.title = "Search"
        vc3.title = "Digimon"

        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always

        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .systemBackground

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)

        nav1.tabBarItem = UITabBarItem(title: "List",
                                       image: UIImage(systemName: "heart"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Digimon",
                                       image: UIImage(named: "digivice_noBG2")?.scaleImage(targetSize:
                                                                                           CGSize(width: 40,
                                                                                                  height: 40)),
                                       tag: 3)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true

        setViewControllers([nav1, nav2, nav3], animated: false)

        vc1.delegate = vc3
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
}
