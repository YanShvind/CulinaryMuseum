
import Foundation
import UIKit

protocol RFavoriteViewViewModelelegate: AnyObject {
    func didSelectRecipes(_ recipe: Recipes)
}

final class RFavoriteViewViewModel: NSObject {
    
    public weak var delegate: RFavoriteViewViewModelelegate?

    var recipes: [Recipes] = []
}

extension RFavoriteViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RFavoriteTableViewCell.identifier,
                                                 for: indexPath) as! RFavoriteTableViewCell
        let recipe = recipes[indexPath.row]
        cell.backgroundColor = .secondarySystemBackground
        cell.configure(name: recipe.name ?? "",
                       time: recipe.time,
                       image: recipe.image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        delegate?.didSelectRecipes(recipe)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completed) in
            completed(true)
            let recipe = self.recipes[indexPath.row]
            RRecipeDataModel.shared.deleteRecipe(withId: recipe.objectID)
            self.recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
