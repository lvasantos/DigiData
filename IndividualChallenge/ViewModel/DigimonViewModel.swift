//
// let d = digimonViewModel()
// d.metodo() // metodo de instancia
// d.variavel // variavel de instancia
//
// digimonViewModel.getDigimonDataByID(0) // metodo de tipo
// digimonViewModel.atributo // variavel de tipo
// Singleton vs Service Locator

import Foundation

class DigimonViewModel {
    let API = APICaller()
    // MARK: Pageable
    func goToNextPage(_ content: PageInfo) async -> PageInfo {
        let nextPage: String = content.pageable.nextPage
        do {
            let (newPageData, _) = try await URLSession.shared.data(
                from: URL(string: nextPage)!)
            let decodedData = JSONDecoder().decodePage(pageData: newPageData)
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
//                print("Voltar para onde que n tem pagina anterior, oras.")
            } else {
                let (previousPageData, _) = try await URLSession.shared.data(
                    from: URL(string: previousPage)!)
                let decodedData = JSONDecoder().decodePage(pageData: previousPageData)
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

    func favoriteStatusCheck(with data: DigimonContent) -> Bool {
        guard let favoriteStatus = data.isFavorite else { return false }
        return favoriteStatus
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
    func getAttributeAndLevel(using decodedData: DigimonContent) -> (String, String) {
        var attributeInfo = "Attribute:\n"
        var levelInfo = "Level:\n"

        do {
            if decodedData.attributes.isEmpty {
                attributeInfo.append("No information\n")
            }
            if decodedData.levels.isEmpty {
                levelInfo.append("No information\n")
            }
            decodedData.attributes.forEach { element in
                attributeInfo.append(informationIsEmpty(with: element.attribute))
            }
            decodedData.levels.forEach { element in
                levelInfo.append(informationIsEmpty(with: element.level))
            }
        }
        return (attributeInfo, levelInfo)
    }

    func getTypeAndField(using decodedData: DigimonContent) -> (String, String) {
        var typeInfo = "Type:\n"
        var fieldInfo = "Field:\n"

        do {
            if decodedData.types.isEmpty {
                typeInfo.append("No information\n")
            }
            if decodedData.fields.isEmpty {
                fieldInfo.append("No information\n")
            }
            decodedData.types.forEach { element in
                typeInfo.append(informationIsEmpty(with: element.type))
            }
            decodedData.fields.forEach { element in
                fieldInfo.append(informationIsEmpty(with: element.field))
            }
        }
        return (typeInfo, fieldInfo)
    }

    func getDescriptionAndStatus(using decodedData: DigimonContent) -> (String, Bool) {
        var descriptionInfo = "Description:\n"
        if decodedData.descriptions.isEmpty {
            descriptionInfo.append("No information")
        } else {
            decodedData.descriptions.forEach { element in
                if element.language == "en_us"{
                    descriptionInfo = element.digiDescription
                    // Por motivos de n sei ele n entrava so com o isEmpty
                } else if element.digiDescription.isEmpty ||
                            element.digiDescription == ""   ||
                            element.digiDescription == " "  ||
                            element.language.isEmpty {
                    descriptionInfo.append("No information")
                }
            }
        }
        if let favoriteStatus = decodedData.isFavorite {
            return (descriptionInfo, favoriteStatus)
        }
            return(descriptionInfo, false)
    }

    func informationIsEmpty(with info: String) -> String {
        var text = ""

        if info.isEmpty {
            text.append("No information\n")
        } else {
            text.append(info)
            text.append("\n")
        }
        return text
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
                                                        nextEvolutions: [],
                                                        isFavorite: false
)

let mockDigimonPage: PageInfo = PageInfo(content: [ContentElement(id: 000, name: "Not Found", href: "")],
                                         pageable: Pageable(currentPage: 0,
                                                            elementsOnPage: 0,
                                                            totalElements: 0,
                                                            totalPages: 0,
                                                            previousPage: "",
                                                            nextPage: "")
)
