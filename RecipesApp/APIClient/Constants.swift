import Foundation

struct Constants {
    
    // Uncomment and replace with your own API key from Spoonacular
    
    // static let apiKey = "063d1857a795427880770e2f44a84d4d"
    // static let apiKey = "73fd55a714424229b20abc76421fc3b1"
    // static let apiKey = "d6080bac713e44768824eb6a664259ec"
    // static let apiKey = "ecf8fe545f5c484aa9dba8388a900f3c"
    // static let apiKey = "db86cbb565e443b09001c62181354145"
    // static let apiKey = "9ad0375acd614e2ebdceb11bddcaf4e6"
    // static let apiKey = "2da9ac50090e42c3a10c7fb6cdb55e87"
    // static let apiKey = "bb0b8e0819f74955b6d4aea39369379f"
    
    static let apiKey = "ecf8fe545f5c484aa9dba8388a900f3c"
    static let baseUrl = "https://api.spoonacular.com"
    
    static let popularRecipesPath = "\(baseUrl)/recipes/complexSearch?apiKey=\(apiKey)&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10&sort=popularity"
    
    static let vegetarianRecipesPath = "\(baseUrl)/recipes/complexSearch?apiKey=\(apiKey)&diet=vegetarian&sort=popularity&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    
    static let shortCookingTimePath = "\(baseUrl)/recipes/complexSearch?apiKey=\(apiKey)&maxReadyTime=20&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    
    static let healthyRecipesPath = "\(baseUrl)/recipes/complexSearch?apiKey=\(apiKey)&health=healthy&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
    
    static let lowCalorieRecipesPath = "\(baseUrl)/recipes/complexSearch?apiKey=\(apiKey)&maxCalories=500&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10"
}

