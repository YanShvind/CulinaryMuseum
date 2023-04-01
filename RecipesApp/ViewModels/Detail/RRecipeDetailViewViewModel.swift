
import Foundation
import UIKit

final class RRecipeDetailViewViewModel: NSObject {
    
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
