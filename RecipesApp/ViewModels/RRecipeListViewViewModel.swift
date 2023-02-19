
import Foundation
import UIKit

protocol RRecipeListViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
}

final class RRecipeListViewViewModel: NSObject {
    
    public weak var delegate: RRecipeListViewViewModelDelegate?
    
    private var recipes: [Recipe] = [] {
        didSet {
            cellViewModels = []
            for recipe in recipes {
                let viewModel = RRecipeCollectionViewCellViewModel(recipeName: recipe.title, recipeImageUrl: URL(string: recipe.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RRecipeCollectionViewCellViewModel] = []
    
    func fetchRecipes(for ingredient: String) {
        RService.shared.fetchRecipes(for: ingredient) { [weak self] results in
            self?.recipes = results
            self?.delegate?.didLoadInitialRecipes()
        }
    }
}

extension RRecipeListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RHomeCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RHomeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let recipe = recipes[indexPath.row]
        
        cell.nameLabel.text = recipe.title
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 0.9)
    }
}

extension RRecipeListViewViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        fetchRecipes(for: textSearched)
    }
}
