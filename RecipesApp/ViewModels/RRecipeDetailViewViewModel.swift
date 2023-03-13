
import Foundation

final class RRecipeDetailViewViewModel {
    
    private let recipe: RRecipe
    private var ingredients: [String] = []
    
    init(recipe: RRecipe) {
        self.recipe = recipe
    }
    
    public var title: String {
        recipe.title.uppercased()
    }
    
    public func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        RImageManager.shared.downloadImage(URL(string: recipe.image)!, complection: completion)
    }
    
    public func fetchRecipeInformation(forId id: Int) {
        RService.shared.fetchRecipeInformation(for: id) { recipeInfo in
            if let ingredients = recipeInfo?.extendedIngredients {
                self.ingredients = ingredients.map { $0.original }
                print(self.ingredients) // Проверяем, что ингредиенты добавлены в массив
            } else {
                print("Error: Unable to fetch recipe information")
            }
        }
    }
}
