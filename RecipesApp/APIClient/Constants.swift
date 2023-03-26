
import Foundation

struct Constants {
    
    //    case apiKey = "063d1857a795427880770e2f44a84d4d"
    //    case apiKey = "73fd55a714424229b20abc76421fc3b1"
    //    case apiKey = "d6080bac713e44768824eb6a664259ec"
    //    case apiKey = "ecf8fe545f5c484aa9dba8388a900f3c"
    //    case apiKey = "db86cbb565e443b09001c62181354145"
    //    case apiKey = "9ad0375acd614e2ebdceb11bddcaf4e6"
    //    case apiKey = "2da9ac50090e42c3a10c7fb6cdb55e87"
    //    case apiKey = "bb0b8e0819f74955b6d4aea39369379f"
    
    static let shared = Constants()

    let apiKey = "063d1857a795427880770e2f44a84d4d"
    let baseUrl = "https://api.spoonacular.com"
    
    let popularRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10&sort=popularity"
    let vegetarianRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&diet=vegetarian&sort=popularity&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    let shortCookingTimePath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&maxReadyTime=20&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    let healthyRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&health=healthy&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    let lowCalorieRecipesPath = "https://api.spoonacular.com/recipes/complexSearch?apiKey=063d1857a795427880770e2f44a84d4d&maxCalories=500&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
}
