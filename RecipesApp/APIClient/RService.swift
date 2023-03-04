
import Foundation

final class RService {
    
    static let shared = RService()
    
    private let apiKey = "b7d3acc52a0c4055a402dba556564503"
    
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
}
