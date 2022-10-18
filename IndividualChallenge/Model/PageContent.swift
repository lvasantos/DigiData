import Foundation

// MARK: - Content
struct PageInfo: Codable {
    let content: [ContentElement]
    let pageable: Pageable
}
// MARK: - ContentElement
struct ContentElement: Codable {
    let id: Int
    let name: String
    let href: String
}
// id e name podem ser usados para procurar o digimon pelo url
// href me leva para pagina de informacoes do digimon que eu separei em DigimonModel

// MARK: - Pageable
struct Pageable: Codable {
    let currentPage, elementsOnPage, totalElements, totalPages: Int
    let previousPage: String
    let nextPage: String
}
