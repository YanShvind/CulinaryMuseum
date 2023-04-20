
import Foundation
import UIKit

protocol RNewRecipeViewViewModelDelegate: AnyObject {
    func didTapNewRecipeButton()
    func didDescriptionButtonTappedL(indexPath: IndexPath)
}

final class RNewRecipeViewViewModel: NSObject {
    
    public weak var delegate: RNewRecipeViewViewModelDelegate?
    
    var recipes: [NewRecipe] = []
}

extension RNewRecipeViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RNewRecipeTableViewCell.identifier,
                                                 for: indexPath) as! RNewRecipeTableViewCell
        cell.backgroundColor = .secondarySystemBackground
        cell.selectionStyle = .none
        cell.delegate = self
        cell.index = indexPath
        cell.configure(name: recipes[indexPath.row].name ?? "",
                       image: recipes[indexPath.row].image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completed) in
            completed(true)
            let recipe = self.recipes[indexPath.row]
            RNewRecipeDataModel.shared.deleteRecipe(withId: recipe.objectID)
            self.recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension RNewRecipeViewViewModel: RNewRecipeTableViewCellDelegate {
    func didDescriptionButtonTapped(indexPath: IndexPath) {
        delegate?.didDescriptionButtonTappedL(indexPath: indexPath)
    }
}
