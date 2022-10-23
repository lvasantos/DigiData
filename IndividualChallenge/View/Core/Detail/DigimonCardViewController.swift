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
        let text = "\(Int.random(in: 1..<100))"
        Task {
            await updateText(intNum: text)
        }
    }

    func doSomething(using url: String) {
        Task {
            let num = await viewModel.getDigimonWithURL(_: url)
            self.navigationItem.title = num.name

            digimonView.typeLabel.text = viewModel.getDigimonType(num.types)
            digimonView.levelLabel.text = viewModel.getDigimonLevel(num.levels)
            digimonView.attibuteLabel.text = viewModel.getDigimonAttribute(num.attributes)
            digimonView.fieldLabel.text = viewModel.getDigimonField(num.fields)

            if let desc = num.descriptions.first?.descriptionDescription {
                digimonView.descriptionText.text = desc
            }
            guard let imageURL = num.images.first?.href else { return }
            let url = URL(string: imageURL)
            guard let url = url else { return }
            let (imageData, _) = try await URLSession.shared.data(from: url)
            digimonView.digimonImage.image = UIImage(data: imageData)

            if !digimonView.flip {
                flipToBackView(options: .transitionFlipFromRight)
            }
            flipToFrontView(options: .transitionCurlUp)

            self.tabBarController?.selectedIndex = 2
        }
    }

    func updateText(intNum: String) async {
        do {
            let num = await viewModel.searchDigimonByID(Int(intNum)!)
            self.navigationItem.title = num.name

            digimonView.typeLabel.text = viewModel.getDigimonType(num.types)
            digimonView.levelLabel.text = viewModel.getDigimonLevel(num.levels)
            digimonView.attibuteLabel.text = viewModel.getDigimonAttribute(num.attributes)
            digimonView.fieldLabel.text = viewModel.getDigimonField(num.fields)

            if let desc = num.descriptions.first?.descriptionDescription {
                digimonView.descriptionText.text = desc
            }
            guard let imageURL = num.images.first?.href else { return }
            let url = URL(string: imageURL)
            guard let url = url else { return }
            let (imageData, _) = try await URLSession.shared.data(from: url)
            digimonView.digimonImage.image = UIImage(data: imageData)

            if !digimonView.flip { flipToBackView(options: .transitionFlipFromRight)}
            flipToFrontView(options: .transitionCurlUp)

        } catch {
            print(error)
        }
    }
}

extension DigimonCardViewController: DigimonCardViewDelegate {
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
        UIView.transition(with: self.digimonView.flipCard,
                          duration: 0.3,
                          options: options,
                          animations: { [unowned self] in
            self.digimonView.digimonImage.isHidden = false
            self.digimonView.labelStack.isHidden = true
            self.digimonView.label2Stack.isHidden = true
            self.digimonView.descriptionText.isHidden = true
            self.digimonView.cardView.isHidden = true
            self.digimonView.flip = !self.digimonView.flip
        })
    }

}

extension DigimonCardViewController: CollectionViewControllerDelegate {

}

/*
 MARK: transition
 delete:
 digimonView.flipToBackView(options: .transitionCurlUp)
 card (image/info)
 digimonView.flipToBackView(options: .transitionFlipFromRight)
 */
