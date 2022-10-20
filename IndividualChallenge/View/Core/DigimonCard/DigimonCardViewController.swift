import UIKit

class DigimonCardViewController: UIViewController {
    private let digimonView = DigimonCardView()
    let viewModel: DigimonViewModel = DigimonViewModel()

    override func loadView() {
        view = digimonView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        digimonView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension DigimonCardViewController: DigimonCardViewDelegate {
    func changeViewContent() {
        let text = "\(Int.random(in: 1..<100))"
        Task {
            let num = await viewModel.searchDigimonByID(Int(text)!)
            digimonView.nameLabel.text = num.name
            digimonView.levelLabel.text = viewModel.getDigimonLevel(num.levels)

            let url = URL(string: num.images.first!.href)!
            let (imageData, _) = try await URLSession.shared.data(from: url)
            digimonView.digimonImage.image = UIImage(data: imageData)

        }
    }
}
