
import Foundation

final class RService {
    
    static let shared = RService()
    
    private let apiKey = "1493d2e9e5c3481fa49fa00c46c7c72f"
    
    func fetchRecipes(for ingredients: String = "", random: Bool = false, completion: @escaping ([RRecipe]) -> Void) {
        var apiUrlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(ingredients)&apiKey=\(apiKey)&addRecipeInformation=true&number=10"
        
        if random {
            apiUrlString += "&offset=\(Int.random(in: 0..<100))"
        }
        
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Error: Invalid API URL")
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(RSearchResults.self, from: data)
                completion(results.results)
            } catch {
                print("Error: \(error)")
                completion([])
            }
        }
        task.resume()
    }
    
    func fetchRecipeInformation(for recipeId: Int, completion: @escaping (RRecipeInformation?) -> Void) {
        let apiUrlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(apiKey)"
        
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Error: Invalid API URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let recipeInfo = try decoder.decode(RRecipeInformation.self, from: data)
                completion(recipeInfo)
            } catch {
                print("Error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
