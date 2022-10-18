//
//  DigimonViewModel.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 15/10/22.
//

import Foundation

// let d = digimonViewModel()
// d.metodo() // metodo de instancia
// d.variavel // variavel de instancia
//
// digimonViewModel.getDigimonDataByID(0) // metodo de tipo
// digimonViewModel.atributo // variavel de tipo
// Singleton vs Service Locator

class DigimonViewModel {
    // MARK: Pageable
    func goToNextPage(_ content: PageInfo) async -> PageInfo {
        let nextPage: String = content.pageable.nextPage
        do {
            let (newPageData, _) = try await URLSession.shared.data(
                from: URL(string: nextPage)!)
            let decodedData = JSONDecoder().decodePage(pageData: newPageData)

            //            print(decodedData)
            return decodedData

        } catch {
            print(error)
        }
        return PageInfo(
            content: [ContentElement(id: 000, name: "Not Found", href: "")],
            pageable: Pageable(
                currentPage: 0,
                elementsOnPage: 0,
                totalElements: 0,
                totalPages: 0,
                previousPage: "",
                nextPage: ""
            )
        )

    }

    func goToPreviousPage(_ content: PageInfo) async -> PageInfo {
        let previousPage: String = content.pageable.previousPage
        do {
            if previousPage == "" {
                print("Voltar que n tem pagina anterior, oras.")

            } else {
                let (previousPageData, _) = try await URLSession.shared.data(
                    from: URL(string: previousPage)!)
                let decodedData = JSONDecoder().decodePage(pageData: previousPageData)

                //                print(decodedData)
                return decodedData
            }

        } catch {
            print(error)
        }
        return PageInfo(
            content: [ContentElement(id: 000, name: "Not Found", href: "")],
            pageable: Pageable(
                currentPage: 0,
                elementsOnPage: 0,
                totalElements: 0,
                totalPages: 0,
                previousPage: "",
                nextPage: ""
            )
        )
    }

// MARK: DigimonCentered
    func getDigimonDataByID (_ digimonID: Int) async -> Digimon {
        do {
            let endpoint = "digimon-api.com/api/v1/digimon/\(digimonID)"
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(Digimon.self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return Digimon(
            id: 0,
            name: "Not found",
            xAntibody: false,
            images: [],
            levels: [],
            types: [],
            attributes: [],
            fields: [],
            releaseDate: "xx",
            descriptions: [],
            skills: [],
            priorEvolutions: [],
            nextEvolutions: []
        )
    }

    func getDigimonDataByName (_ digimonName: String) async {
        do {
            let endpoint = "digimon-api.com/api/v1/digimon/\(digimonName)"
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(Digimon.self, from: data)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}

// E se eu quiser retornar o erro para tratar fora ?
extension JSONDecoder {
    func decodePage (pageData: Data) -> PageInfo {
        do {
            let decodedData = try self.decode(PageInfo.self, from: pageData)
            return decodedData
        } catch {
            print(error)
        }
        return PageInfo(
            content: [ContentElement(id: 000, name: "Not Found", href: "")],
            pageable: Pageable(
                currentPage: 0,
                elementsOnPage: 0,
                totalElements: 0,
                totalPages: 0,
                previousPage: "",
                nextPage: ""
            )
        )
    }
}
