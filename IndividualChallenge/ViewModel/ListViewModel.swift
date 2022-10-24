//
//  DigimonListViewModel.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 19/10/22.
//

import Foundation
import UIKit

struct ListViewModel {
    func getPageLink(completion: @escaping ([String]) -> Void) {
        var array: [String] = []
        APICaller().digimonFirstEntry { result in
            result.content.forEach { element in
                array.append(element.href)
            }
            completion(array)
        }
    }

    func getAllLinks(completion: @escaping ([String]) -> Void) {
        var links: [String] = []
        var array: [String] = []

        // Dps modificar para receber o total de páginas = 283
        //
        for page in 1...20 {
            let url: String = "https://digimon-api.com/api/v1/digimon?page="
            let pageNum = String(page)
            links.append("\(url)\(page)")
            links.sorted()
        }

        links.forEach { pageLink in
            if let pageURL = URL(string: pageLink) {

                APICaller().digimonEntry(pageURL: pageURL) { element in
                    element.forEach { elementLink in
                        array.append(elementLink)
                    }
                    completion(array)
                }
            }
        }
    }
}
