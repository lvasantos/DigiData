import UIKit

class CharacterListViewCell: UICollectionViewCell {
    static let identifier = "CharacterListCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .darkGray
        imageView.image = UIImage(systemName: "questionmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.clipsToBounds = true

        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.gray.cgColor

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)

        //        let images = [].compactMap({$0})
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
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

    func selected() {
        
    }
}
