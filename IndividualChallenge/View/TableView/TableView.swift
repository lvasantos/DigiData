//
//  TableView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 20/10/22.
//

import UIKit

class TableView: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Favorite"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
