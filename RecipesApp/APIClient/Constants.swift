
import Foundation

struct Constants {
    
    static let shared = Constants()

    let apiKey = "b7d3acc52a0c4055a402dba556564503"
    let baseUrl = "https://api.spoonacular.com"
    
    let vegetarianRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&diet=vegetarian&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    let popularRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10&sort=popularity"
}
