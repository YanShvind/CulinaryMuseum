
import Foundation

final class RService {
    
    static let shared = RService()
    
    private let apiKey = Constants.apiKey
    private let baseURL = Constants.baseUrl

    // Запрос для поиска рецептов
    func fetchRecipes(for ingredients: String = "", random: Bool = false, completion: @escaping ([RRecipe]) -> Void) {
        var apiUrlStringForSearch = "\(baseURL)/recipes/complexSearch?query=\(ingredients)&apiKey=\(apiKey)&addRecipeInformation=true&number=10"
        
        if random {
            apiUrlStringForSearch += "&offset=\(Int.random(in: 0..<100))"
        }
        
        guard let apiUrl = URL(string: apiUrlStringForSearch) else {
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
    
    // Запрос для получения информации о рецепте
    func fetchRecipeInformation(for recipeId: Int, completion: @escaping (RRecipeInformation?) -> Void) {
        let apiUrlStringForInformation = "\(baseURL)/recipes/\(recipeId)/information?apiKey=\(apiKey)"
        
        guard let apiUrl = URL(string: apiUrlStringForInformation) else {
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
    
    // Запрос для разных категорий
    func fetchRecipesByUrl(for apiUrlString: String, completion: @escaping ([RRecipe]) -> Void) {
        let apiUrlStringForSearch = apiUrlString
        
        guard let apiUrl = URL(string: apiUrlStringForSearch) else {
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
