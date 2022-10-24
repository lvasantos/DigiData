//
//  APICaller.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import Foundation

class APICaller {
    private let url = "digi-api.com/api/v1/digimon/"

    func digimonFirstEntry(completionHandler: @escaping (PageInfo) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: "https:www.\(url)")!,
                                              completionHandler: { (data, _, error) in
            if let error = error {
                print("⚠️ Error with fetching  data: \(error)")
                return
            }
            if let data = data,
               let userData = try? JSONDecoder().decode(PageInfo.self, from: data) {
                completionHandler(userData)
            }
        })
        task.resume()
    }

    func digimonEntry(pageURL: URL, completionHandler: @escaping ([String]) -> Void) {
        var array: [String] = []
        let task = URLSession.shared.dataTask(with: pageURL,
                                              completionHandler: { (data, _, _) in
            if let data = data,
               let pageData = try? JSONDecoder().decode(PageInfo.self, from: data) {
                pageData.content.forEach { element in
                    array.append(element.href)
                }
                completionHandler(array)
            }
        })
        task.resume()
    }

    func fetchdigimonFirstEntry() async -> PageInfo? {
        do {
            let endpoint = url
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https:www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(PageInfo.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    func fetchRandomDigimon() async  -> DigimonContent? {
        do {
            let random = String(Int.random(in: 1..<600))
            let url = url
            let endpoint = url.appending(random)
            let (data, _) = try await URLSession.shared.data(
                from: URL(
                    string: "https://www.\(endpoint)")!)
            let digimonDecoded = try JSONDecoder().decode(DigimonContent.self, from: data)
            return digimonDecoded
        } catch {
            print(error)
        }
        return nil
    }
}
