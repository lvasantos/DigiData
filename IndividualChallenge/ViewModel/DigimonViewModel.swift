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
    let API = APICaller()
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
        return mockDigimonPage

    }

    func goToPreviousPage(_ content: PageInfo) async -> PageInfo {
        let previousPage: String = content.pageable.previousPage
        do {
            if previousPage == "" {
                print("Voltar para onde que n tem pagina anterior, oras.")
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
        return mockDigimonPage
    }
    // MARK: DigimonsPerPage
    func getDigimonLinkPerPage(_ content: PageInfo) async -> [String] {
        var digimonLink: [String] = []
        content.content.forEach { digimonContent in
            digimonLink.append(digimonContent.href)
        }

        return digimonLink
    }
    // MARK: DigimonCentered
    func getDigimonWithURL(_ urlString: String) async -> DigimonContent {
        do {
            guard let URL = URL(string: urlString) else {
                return mockDigimonContent
            }
            let (data, _) = try await URLSession.shared.data(from: URL)
            let decodedData = try JSONDecoder().decode(DigimonContent.self, from: data)
            return decodedData

        } catch {
            print(error)
        }
        return mockDigimonContent
    }

    // MARK: Search
    func searchDigimonByID (_ digimonID: Int) async -> DigimonContent {
        do {
            let endpoint = "digimon-api.com/api/v1/digimon/\(digimonID)"
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(DigimonContent.self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return mockDigimonContent
    }

    func searchDigimonByName (_ digimonName: String) async -> DigimonContent {
        do {
            let endpoint = "digimon-api.com/api/v1/digimon/\(digimonName)"
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "https://www.\(endpoint)")!)
            let decodedData = try JSONDecoder().decode(DigimonContent.self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return mockDigimonContent
    }

    // MARK: Digimon attributes and infos
    func getDigimonLevel(_ level: [Level]) -> String {
        var string = "Level:\n"
        if level.isEmpty {
            return "No level information"
        }
        level.forEach { element in
            string.append(element.level)
            string.append("\n")
        }
        return string
    }

    func getDigimonType(_ type: [TypeElement]) -> String {
        var string = "Type:\n"
        if type.isEmpty {
            return "No type information"
        }
        type.forEach { element in
            string.append(element.type)
            string.append("\n")
        }
        return string
    }

    func getDigimonAttribute(_ attribute: [Attribute]) -> String {
        var string = "Attribute:\n"
        if attribute.isEmpty {
            return "No attribute information"
        }
        attribute.forEach { element in
            string.append(element.attribute)
            string.append("\n")
        }
        return string
    }

    func getDigimonField(_ field: [Field]) -> String {
        var string = "field:\n"
        if field.isEmpty {
            return "No field information"
        }
        field.forEach { element in
            string.append(element.field)
            string.append("\n")
        }
        return string
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
        return mockDigimonPage
    }
}

let mockDigimonContent: DigimonContent = DigimonContent(id: 0,
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

let mockDigimonPage: PageInfo = PageInfo(content: [ContentElement(id: 000, name: "Not Found", href: "")],
                                         pageable: Pageable(currentPage: 0,
                                                            elementsOnPage: 0,
                                                            totalElements: 0,
                                                            totalPages: 0,
                                                            previousPage: "",
                                                            nextPage: "")
)
