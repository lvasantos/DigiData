import Foundation

// MARK: - Digimon
struct DigimonContent: Codable {
    let id: Int
    let name: String
    let xAntibody: Bool
    let images: [Image]
    let levels: [Level]
    let types: [TypeElement]
    let attributes: [Attribute]
    let fields: [Field]
    let releaseDate: String
    let descriptions: [Description]
    let skills: [Skill]
    let priorEvolutions: [Evolution]
    let nextEvolutions: [Evolution]
    var isFavorite: Bool? = false
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: Int
    let attribute: String
}

// MARK: - Description
struct Description: Codable {
    let origin, language, digiDescription: String

    enum CodingKeys: String, CodingKey {
        case origin, language
        case digiDescription = "description"
    }
}

// MARK: - Field
struct Field: Codable {
    let id: Int
    let field: String
}

// MARK: - Image
struct Image: Codable {
    let href: String
    let transparent: Bool
}

// MARK: - Level
struct Level: Codable {
    let id: Int
    let level: String
}

// MARK: - Evolution
struct Evolution: Codable {
    let id: Int?
    let digimon, condition: String
}

// MARK: - Skill
struct Skill: Codable {
    let id: Int
    let skill, translation, skillDescription: String

    enum CodingKeys: String, CodingKey {
        case id, skill, translation
        case skillDescription = "description"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let id: Int
    let type: String
}
