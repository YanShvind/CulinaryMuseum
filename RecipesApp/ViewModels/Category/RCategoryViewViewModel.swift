
import Foundation
import UIKit

protocol RCategoryViewViewModelDelegate: AnyObject {
    func rCategoryViewViewModel(_ viewModel: RCategoryViewViewModel, didSelectCategory category: String)
}

final class RCategoryViewViewModel: NSObject {
    
    weak var delegate: RCategoryViewViewModelDelegate?
    
    private let categoriesArray = ["Breakfast", "Lunch", "Dinner", "Appetizers", "Bread", "Beverages", "Desserts", "Potato", "Soups"]
    private let imagesCategoryArray: [UIImage] = ["breakfast", "lunch", "dinner", "appetizers", "bakery", "beverages", "dessert", "maincourse", "soup"].compactMap
    { UIImage(named: $0) }
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
        
        cell.configure(nameLabelText: categoriesArray[indexPath.row], categoryImage: imagesCategoryArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoriesArray[indexPath.row]
        delegate?.rCategoryViewViewModel(self, didSelectCategory: selectedCategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-40)/3
        return CGSize(width: width, height: bounds.height * 0.2)
    }
}
