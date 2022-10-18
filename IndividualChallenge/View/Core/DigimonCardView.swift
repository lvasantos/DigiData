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

    let title: UILabel = {
        let  label = UILabel()
        label.text = "Fetch digimon"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
//        label.sizeToFit()

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
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let settingView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let digimonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .green
        imageView.tintColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(favoriteButton)
        addSubview(settingView)
        settingView.addSubview(digimonImage)
        addSubview(title)
        favoriteButton.addTarget(self, action: #selector(changeText), for: .touchUpInside)
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setConstraints()
        addGradientWithColor(color: .purple)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func changeText() {
        delegate?.changeViewContent()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            settingView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -(self.height/5)),
            settingView.widthAnchor.constraint(equalToConstant: self.width-40),
            settingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            settingView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),

            favoriteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),

            digimonImage.topAnchor.constraint(equalTo: settingView.centerYAnchor, constant: -(self.height/10)),
            digimonImage.widthAnchor.constraint(equalTo: settingView.widthAnchor),
            digimonImage.bottomAnchor.constraint(
                equalTo: settingView.bottomAnchor, constant: 10),

            title.leadingAnchor.constraint(equalTo: settingView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(
                equalTo: settingView.trailingAnchor, constant: -20),
            title.topAnchor.constraint(equalTo: settingView.topAnchor, constant: 20)

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
