
import Foundation

struct Constants {
    
    static let shared = Constants()

    let apiKey = "b7ca7001f0ea4607add6eec8873b6f6f"
    let baseUrl = "https://api.spoonacular.com"
    
    let vegetarianRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=b7ca7001f0ea4607add6eec8873b6f6f&diet=vegetarian&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
}
