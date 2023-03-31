
import Foundation
import UIKit

final class RFavoriteViewViewModel: NSObject {
    
}

extension RFavoriteViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RFavoriteTableViewCell.identifier, for: indexPath) as! RFavoriteTableViewCell
        
        return cell 
    }
}
