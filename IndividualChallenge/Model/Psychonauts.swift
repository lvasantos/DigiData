import Foundation

// MARK: Characters Model
struct Character: Codable {
    let gender, img, name: String
    let psiPowers: [PsiPower]

}

// MARK: Psipowers Model
struct PsiPower: Codable {
    let description, img, name: String

}
