
import Foundation
import UIKit

final class RRecipeDetailViewViewModel: NSObject {
    
    private let recipe: RRecipe
    private var ingredients: [String] = []
    
    init(recipe: RRecipe) {
        self.recipe = recipe
    }
    
    init(recipes: Recipes) {
        let imageData = recipes.image!
        let base64String = imageData.base64EncodedString()
        
        let utf8String = String(data: imageData, encoding: .utf8)
        self.recipe = RRecipe(id: Int(recipes.id),
                              title: recipes.name!,
                              image: base64String,
                              readyInMinutes: Int(recipes.time))
        self.ingredients = []
        super.init()
    }
    
    public var title: String {
        recipe.title.uppercased()
    }
    
    public func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: recipe.image) else {
              print("Error: invalid URL")
              return
          }
        RImageManager.shared.downloadImage(url,
                                           complection: completion)
    }
    
    public func fetchRecipeInformation(forId id: Int) {
        RService.shared.fetchRecipeInformation(for: id) { recipeInfo in
            if let ingredients = recipeInfo?.extendedIngredients {
                DispatchQueue.main.async { [weak self] in
                    self?.ingredients = ingredients.map { $0.original }
                }
            } else {
                print("Error: Unable to fetch recipe information")
            }
        }
    }
}

extension RRecipeDetailViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RRecipeDetailTableViewCell.cellIdentifier, for: indexPath) as! RRecipeDetailTableViewCell
        cell.backgroundColor = .secondarySystemBackground
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}
