//
//  ViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 20/10/22.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var infos: [Info] = []

    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CHRIST"
        infos = fetchDummyData()
        configureTableView()
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.separatorColor = .black
        tableView.register(InfoCell.self, forCellReuseIdentifier: "VideoCell")
        tableView.pin(to: view)
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeue(withIdentifier: "VideoCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? InfoCell
        let info = infos[indexPath.row]
        cell?.set(info: info)

        return cell!
    }
}

extension ViewController {
    func fetchDummyData() -> [Info] {
        let dummy1 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy2 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy3 = Info(image: UIImage(systemName: "star")!, title: "not Filled star")
        let dummy4 = Info(image: UIImage(systemName: "heart.fill")!, title: "Filled heart")
        let dummy5 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy6 = Info(image: UIImage(systemName: "questionmark")!, title: "PLEASE STOP")
        let dummy7 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy8 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy9 = Info(image: UIImage(systemName: "star")!, title: "not Filled star")
        let dummy10 = Info(image: UIImage(systemName: "heart.fill")!, title: "Filled heart")
        let dummy11 = Info(image: UIImage(systemName: "star.fill")!, title: "Filled star")
        let dummy12 = Info(image: UIImage(systemName: "questionmark")!, title: "PLEASE STOP")

        return [dummy1, dummy2, dummy3, dummy4, dummy5, dummy6, dummy7, dummy8, dummy9, dummy10, dummy11, dummy12]

    }
}

// n me permite acessar method, why? whyyy?
extension UITableView {
    func dequeue<T: UITableViewCell> (withIdentifier id: String, for indP: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: id, for: indP) as? T else {
            fatalError("could not cast cell")
        }
        return cell
    }
}
