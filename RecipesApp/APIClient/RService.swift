
import Foundation

final class RService {
    
    static let shared = RService()
    
    private let apiKey = "b7ca7001f0ea4607add6eec8873b6f6f"
    
    func fetchRecipes(for ingredients: String, completion: @escaping ([RRecipe]) -> Void) {
        guard let apiUrl = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=\(ingredients)&apiKey=\(apiKey)&addRecipeInformation=true") else {
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
}
