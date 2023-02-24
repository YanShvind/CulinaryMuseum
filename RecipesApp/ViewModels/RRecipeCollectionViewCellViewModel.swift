
import Foundation

final class RRecipeCollectionViewCellViewModel {
    public let recipeName: String
    public let recipeTime: Int
    private let recipeImageUrl: URL?
    
    init(recipeName: String, recipeTime: Int, recipeImageUrl: URL?) {
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.recipeImageUrl = recipeImageUrl
    }
    
    public func fetchImage(complection: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = recipeImageUrl else {
            print("Invalid image URL")
            return
        }
        let request = URLRequest(url: imageUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            complection(.success(data))
        }
        task.resume()
    }
}
