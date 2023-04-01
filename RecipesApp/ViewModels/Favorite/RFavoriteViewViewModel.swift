
import Foundation
import UIKit

final class RFavoriteViewViewModel: NSObject {
    var recipes: [Recipes] = []
}

extension RFavoriteViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RFavoriteTableViewCell.identifier, for: indexPath) as! RFavoriteTableViewCell
        cell.configure(name: recipes[indexPath.row].name!, time: recipes[indexPath.row].time, image: recipes[indexPath.row].image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        RRecipeDataModel.shared.deleteRecipe(withId: recipe.objectID)
        recipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
