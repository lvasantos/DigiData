//
//  TableViewCell.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 20/10/22.
//

import UIKit

class InfoCell: UITableViewCell {

    var characterImageView = UIImageView()
    var characterName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(characterImageView)
        addSubview(characterName)

        configureImage()
        configureLabel()

        setImageConstraints()
        setLabelConstraints()
    }
    // instancia de collectionvview

    // func config <- [itens da collection]
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(info: Info) {
        characterImageView.image = info.image
        characterName.text = info.title
    }

    func configureImage() {
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.backgroundColor = .darkGray
        characterImageView.image = UIImage(
                systemName: "questionmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        characterImageView.clipsToBounds = true

        characterImageView.layer.cornerRadius = 25
        characterImageView.layer.borderWidth = 3
        characterImageView.layer.borderColor = UIColor.gray.cgColor

    }

    func configureLabel() {
        characterName.numberOfLines = 0
        characterName.adjustsFontSizeToFitWidth = true
    }

    func setImageConstraints() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            characterImageView.heightAnchor.constraint(equalToConstant: 80),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 16/9)

        ])
    }

    func setLabelConstraints() {
        characterName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterName.centerYAnchor.constraint(equalTo: centerYAnchor),
            characterName.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 20),
            characterName.heightAnchor.constraint(equalToConstant: 80),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)

        ])
    }
}
