import UIKit

class DigimonCardViewController: UIViewController {

    private let digimonView = DigimonCardView()
    private let collectionView = CollectionViewController()
    private let viewModel: DigimonViewModel = DigimonViewModel()

    override func loadView() {
        view = digimonView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        digimonView.delegate = self

    }

    func changeViewContent() {
        let idDigi = Int.random(in: 1..<500)
        Task {
            let data = await viewModel.searchDigimonByID(idDigi)
            await textUpdate(using: data)
        }
    }

    func textUpdate(using data: DigimonContent) async {
        self.navigationItem.title = data.name

        if !digimonView.flip { flipToBackView(options: .transitionFlipFromRight) }
        flipToFrontView(options: .transitionCurlUp)

        (digimonView.attibuteLabel.text, digimonView.levelLabel.text) = viewModel.getAttributeAndLevel(using: data)
        (digimonView.typeLabel.text, digimonView.fieldLabel.text) = viewModel.getTypeAndField(using: data)
        (digimonView.descriptionText.text, digimonView.fave) = viewModel.getDescriptionAndStatus(using: data)

        if let imageString = data.images.first?.href {
            if let url = URL(string: imageString) {
                do {
                    let (imageData, _) = try await URLSession.shared.data(from: url)
                    digimonView.digimonImage.image = UIImage(data: imageData)
                } catch {
                    print(error)
                }
            }
        }

        if !digimonView.fave {
            favoriteUnchecked()
        } else {
            favoriteChecked()
        }
    }
}

extension DigimonCardViewController: CollectionViewControllerDelegate {
    func doSomething(using url: String) {
        Task {
            let num = await viewModel.getDigimonWithURL(_: url)
            self.navigationItem.title = num.name

            await textUpdate(using: num)
            self.tabBarController?.selectedIndex = 2
        }
    }
}

extension DigimonCardViewController: DigimonCardViewDelegate {

    func favoriteChecked() {
        self.digimonView.favoriteButton.configuration?.baseForegroundColor = .systemPink
        self.digimonView.favoriteButton.configuration?.image = UIImage(systemName: "heart.fill")
        self.digimonView.fave = !self.digimonView.fave
    }

    func favoriteUnchecked() {
        self.digimonView.favoriteButton.configuration?.baseForegroundColor = .systemPink
        self.digimonView.favoriteButton.configuration?.image = UIImage(systemName: "heart")
        self.digimonView.fave = !self.digimonView.fave
    }

    func flipToBackView(options: UIView.AnimationOptions) {
        UIView.transition(with: self.digimonView.flipCard,
                          duration: 0.3,
                          options: options,
                          animations: { [unowned self] in

            self.digimonView.digimonImage.isHidden = true
            self.digimonView.labelStack.isHidden = false
            self.digimonView.label2Stack.isHidden = false
            self.digimonView.descriptionText.isHidden = false
            self.digimonView.cardView.isHidden = false
            self.digimonView.flip = !self.digimonView.flip
        })
    }
    

    func flipToFrontView(options: UIView.AnimationOptions) {
        UIView.transition(with: self.digimonView.flipCard, duration: 0.3,
                          options: options, animations: { [unowned self] in

            self.digimonView.digimonImage.isHidden = false
            self.digimonView.labelStack.isHidden = true
            self.digimonView.label2Stack.isHidden = true
            self.digimonView.descriptionText.isHidden = true
            self.digimonView.cardView.isHidden = true
            self.digimonView.flip = !self.digimonView.flip
        })
    }

}

/*
 MARK: transition
 delete:
 digimonView.flipToBackView(options: .transitionCurlUp)
 card (image/info)
 digimonView.flipToBackView(options: .transitionFlipFromRight)
 */
