
import Foundation

final class RRecipeDetailViewViewModel {
    private let recipe: RRecipe
    
    init(recipe: RRecipe) {
        self.recipe = recipe
    }
    
    public var title: String {
        recipe.title.uppercased()
    }
}
