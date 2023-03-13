
import Foundation

struct RRecipeInformation: Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let sourceName: String?
    let extendedIngredients: [RExtendedIngredient]
}

struct RExtendedIngredient: Codable {
    let id: Int
    let name: String
    let image: String?
    let original: String
    let amount: Double
    let unit: String
}
