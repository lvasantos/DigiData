//
//  DigimonView.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 15/10/22.
//

import UIKit

protocol DigimonCardViewDelegate: AnyObject {
    func changeViewContent()
    func flipToBackView(options: UIView.AnimationOptions)
    func flipToFrontView(options: UIView.AnimationOptions)
    func favoriteChecked()
    func favoriteUnchecked()
}

class DigimonCardView: UIView {
    // MARK: variáveis
    weak var delegate: DigimonCardViewDelegate?
    var flip: Bool = false
    var fave: Bool = false

    let flipCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.image = UIImage(systemName: "heart")
        configuration.baseForegroundColor = .systemPink
        configuration.baseBackgroundColor = UIColor.white
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let shuffleButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.image = UIImage(systemName: "shuffle")
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor.systemPink
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let digimonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "digimon_noImage")
        imageView.backgroundColor = .lightGray
        imageView.tintColor = .systemPink
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let cardView: UIStackView = {
        let view = UIStackView()
        view.alignment = .bottom
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -2.0)
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 5.0
        view.layer.shadowRadius = 5.0
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.isUserInteractionEnabled = false
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let typeLabel: UILabel = {
        let  label = UILabel()
        label.text = "type"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let levelLabel: UILabel = {
        let  label = UILabel()
        label.text = "level"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelStack: UIStackView = {
        let view = UIStackView()
        view.alignment = .top
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let attibuteLabel: UILabel = {
        let  label = UILabel()
        label.text = "attribute"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let fieldLabel: UILabel = {
        let  label = UILabel()
        label.text = "field"
        label.textColor = .systemPink
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let label2Stack: UIStackView = {
        let view = UIStackView()
        view.alignment = .top
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let descriptionText: UITextView = {
        let text = UITextView()
        text.text = "description"
        text.textColor = .systemPink
        text.layer.masksToBounds = true
        text.isEditable = false
        text.isSelectable = false
        text.font = UIFont.preferredFont(forTextStyle: .body)
        text.backgroundColor = .clear
        text.isHidden = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    // MARK: overrides, init
    override init(frame: CGRect) {
        super.init(frame: frame)
        shuffleButton.addTarget(self, action: #selector(changeText), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        flipCard.addGestureRecognizer(tap)
        configFlipCard()
        configLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        addGradientWithColor(color: .purple)
        setConstraints()
        configCardHeight()
    }

    // MARK: funções
    func configFlipCard() {
        // n precisa testar
        flipCard.addSubview(label2Stack)
        flipCard.addSubview(labelStack)
        flipCard.addSubview(digimonImage)
        flipCard.addSubview(shuffleButton)
        flipCard.addSubview(favoriteButton)
        flipCard.addSubview(descriptionText)
        flipCard.addSubview(cardView)
        addSubview(flipCard)
    }

    func configLabels() {
        // n precisa testar
        labelStack.addArrangedSubview(typeLabel)
        labelStack.addArrangedSubview(levelLabel)
        label2Stack.addArrangedSubview(attibuteLabel)
        label2Stack.addArrangedSubview(fieldLabel)
    }

    func configCardHeight() {
        // n precisa testar
        self.flipCard.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.675).isActive = true
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            self.flipCard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.flipCard.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.flipCard.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.shuffleButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                         constant: -20 ),
            self.shuffleButton.bottomAnchor.constraint(equalTo: self.flipCard.bottomAnchor, constant: -20),

            self.favoriteButton.trailingAnchor.constraint(equalTo: self.shuffleButton.leadingAnchor, constant: -20),
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.flipCard.bottomAnchor, constant: -20),

            self.digimonImage.topAnchor.constraint(equalTo: self.flipCard.topAnchor),
            self.digimonImage.leadingAnchor.constraint(equalTo: self.flipCard.leadingAnchor),
            self.digimonImage.trailingAnchor.constraint(equalTo: self.flipCard.trailingAnchor),
            self.digimonImage.bottomAnchor.constraint(equalTo: self.flipCard.bottomAnchor),

            self.labelStack.leadingAnchor.constraint(equalTo: self.flipCard.leadingAnchor, constant: 20),
            self.labelStack.trailingAnchor.constraint(equalTo: self.flipCard.trailingAnchor),

            self.label2Stack.topAnchor.constraint(equalTo: self.labelStack.bottomAnchor),
            self.label2Stack.leadingAnchor.constraint(equalTo: self.flipCard.leadingAnchor, constant: 20),
            self.label2Stack.trailingAnchor.constraint(equalTo: self.flipCard.trailingAnchor),
            self.label2Stack.bottomAnchor.constraint(equalTo: self.shuffleButton.topAnchor),

            self.cardView.topAnchor.constraint(equalTo: self.flipCard.topAnchor),
            self.cardView.leadingAnchor.constraint(equalTo: self.flipCard.leadingAnchor),
            self.cardView.trailingAnchor.constraint(equalTo: self.flipCard.trailingAnchor),
            self.cardView.bottomAnchor.constraint(equalTo: self.labelStack.topAnchor),

            self.descriptionText.leadingAnchor.constraint(equalTo: flipCard.leadingAnchor, constant: 20),
            self.descriptionText.trailingAnchor.constraint(equalTo: flipCard.trailingAnchor, constant: -20),
            self.descriptionText.topAnchor.constraint(equalTo: flipCard.topAnchor),
            self.descriptionText.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
    }

    // n testar
    @objc func changeText() {
        delegate?.changeViewContent()
    }
    // n testar
    @objc func tapped() {
        if flip {
            delegate?.flipToFrontView(options: .transitionFlipFromRight)
        } else {
            delegate?.flipToBackView(options: .transitionFlipFromLeft)
        }
    }
    // n testar
    @objc func favoriteTapped() {
        if fave {
            delegate?.favoriteChecked()
        } else {
            delegate?.favoriteUnchecked()
        }
    }
}

// MARK: extensions
// Teste de rota tudo mockado
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
