//
//  HomeViewController.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import UIKit
import Foundation

class DigimonListViewController: UIViewController {
    private let digimonView = DigimonCardView()
    let viewModel: DigimonViewModel = DigimonViewModel()

    override func loadView() {
        view = digimonView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        digimonView.delegate = self
    }
}

extension DigimonListViewController: DigimonCardViewDelegate {
    func changeViewContent() {
        let text = "\(Int.random(in: 1..<100))"
        Task {
            let num = await viewModel.getDigimonDataByID(_: Int(text)!)
            digimonView.title.text = num.name

            let url = URL(string: num.images.first!.href)!
            let (imageData, _) = try await URLSession.shared.data(from: url)
            digimonView.digimonImage.image = UIImage(data: imageData)
            digimonView.digimonImage.backgroundColor = .white
//            self.digimonView.digimonImage.layer.masksToBounds = true

        }
    }
}

// extension URLSession {
//    func getImageFromURL(_ url: URL) async -> Data {
//
//        do {
//            let (imageData, _) = try await URLSession.shared.data(from: url)
//
//            return imageData
//        } catch {
//            print(error)
//        }
//        return Data()
//    }
// }
