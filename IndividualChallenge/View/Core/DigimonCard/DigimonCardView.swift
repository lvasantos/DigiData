//
//  DigimonView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 15/10/22.
//

import UIKit

protocol DigimonCardViewDelegate: AnyObject {
    func changeViewContent()
}

class DigimonCardView: UIView {
    weak var delegate: DigimonCardViewDelegate?

    let nameLabel: UILabel = {
        let  label = UILabel()
        label.text = "Fetch digimon"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let levelLabel: UILabel = {
        let  label = UILabel()
        label.text = "level"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .white
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Next"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor.systemPink

        button.configuration = configuration
        button.layer.cornerRadius = 15
        configuration.cornerStyle = .capsule
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let descriptionButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
//        configuration.title = "desc"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor.systemPink

        button.configuration = configuration
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 10)
        button.setImage(UIImage(systemName: "star"), for: .normal)

//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let skillButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "skill"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor.systemPink

        button.configuration = configuration
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let digimonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
//        imageView.contentMode = .center
        imageView.backgroundColor = .lightGray
        imageView.tintColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let cardView: UIStackView = {
        let view = UIStackView()
        view.alignment = .bottom
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let buttonStack: UIStackView = {
        let view = UIStackView()
        view.alignment = .bottom
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 5
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView.addArrangedSubview(nameLabel)
        cardView.addArrangedSubview(levelLabel)
        cardView.addArrangedSubview(digimonImage)
        addSubview(cardView)

        buttonStack.addArrangedSubview(favoriteButton)
        buttonStack.addArrangedSubview(descriptionButton)

        addSubview(buttonStack)

        favoriteButton.addTarget(self, action: #selector(changeText), for: .touchUpInside)
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addGradientWithColor(color: .purple)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func changeText() {
        delegate?.changeViewContent()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            cardView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 80),

            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -(self.height/4)),

            levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),

            digimonImage.widthAnchor.constraint(equalTo: cardView.widthAnchor),
            digimonImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: (self.height/5)+20),

            buttonStack.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buttonStack.widthAnchor.constraint(equalTo: self.widthAnchor),

            favoriteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            descriptionButton.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor)
        ])
    }
}

extension UIImageView {
    func load(URL: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
}
