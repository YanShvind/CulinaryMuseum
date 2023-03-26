
import Foundation
import UIKit

final class RCategoryViewViewModel: NSObject {
    
    private let categoriesArray = ["Breakfast", "Lunch", "Dinner", "Appetizers", "Bakery", "Beverages", "Desserts", "Main Course", "Soups"]
}

extension RCategoryViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RCategoryCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RCategoryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-40)/3
        return CGSize(width: width, height: bounds.height * 0.2)
    }
}
