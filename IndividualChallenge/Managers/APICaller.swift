//
//  APICaller.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import Foundation

class APICaller {

    static func fetchdigimonFirstEntry() async -> PageInfo? {
        do {
            let endpoint = "digi-api.com/api/v1/digimon"
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https:www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(PageInfo.self, from: data)

            return decodedData

        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    static func fetchRandomDigimon() async  -> Digimon? {
        do {

            let random = Int.random(in: 1..<600)
            let endpoint = "digi-api.com/api/v1/digimon/\(random)"
            let (data, _) = try await URLSession.shared.data(
                from: URL(
                string: "https://www.\(endpoint)")!)
            let digimonDecoded = try JSONDecoder().decode(Digimon.self, from: data)
            return digimonDecoded

        } catch {
            print(error)
        }
        return nil
    }
}
