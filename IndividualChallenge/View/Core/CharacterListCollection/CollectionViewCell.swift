import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterListCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(systemName: "questionmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let favoriteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.image = UIImage(systemName: "heart.fill")
        configuration.contentInsets = .zero
        configuration.baseForegroundColor = .systemPink
        configuration.baseBackgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.configuration = configuration
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
//                imageView.addSubview(favoriteButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //                imageView.image = nil
    }

    func configure(digiData: String) {
        Task {
            // PEGAR HREF
            guard let url = URL(string: "\(digiData)") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(DigimonContent.self, from: data)

            guard let imageURL = decodedData.images.first?.href else { return }
            if let unwrappedURL = URL(string: imageURL) {
                let(image, _) = try await URLSession.shared.data(from: unwrappedURL)

                imageView.image = UIImage(data: image)
            }
        }
    }

    private func configButton() {
        let buttonWidth = imageView.frame.size.width*0.2
        let buttonHeight = buttonWidth
        favoriteButton.frame = CGRect(x: imageView.width-buttonWidth-10,
                                      y: imageView.height-buttonHeight-10,
                                      width: buttonWidth,
                                      height: buttonHeight)
    }
}
