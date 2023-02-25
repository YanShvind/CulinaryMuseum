
import Foundation

final class RHomeDetailViewViewModel {
    private let recipe: RRecipe
    
    init(recipe: RRecipe) {
        self.recipe = recipe
    }
    
    public var title: String {
        recipe.title.uppercased()
    }
}
