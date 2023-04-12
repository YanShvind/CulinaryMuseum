
import Foundation
import UIKit

protocol RNewRecipeViewViewModelDelegate: AnyObject {
    func didTapNewRecipeButton()
}

final class RNewRecipeViewViewModel: NSObject {
    
}

extension RNewRecipeViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RNewRecipeTableViewCell.identifier,
                                                 for: indexPath) as! RNewRecipeTableViewCell
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
}
