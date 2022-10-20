//
//  DigimonListViewModel.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 19/10/22.
//

import Foundation
import UIKit

struct CharacterListViewModel {
    func getPageLink(completion: @escaping ([String]) -> Void) {
        var array: [String] = []
        APICaller().digimonFirstEntry { result in
            result.content.forEach { element in
                array.append(element.href)
            }
            completion(array)
        }
    }
}
