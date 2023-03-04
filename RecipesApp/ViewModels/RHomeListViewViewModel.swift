
import Foundation
import UIKit

protocol RHomeListViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
    func diSelectRecipes(_ recipe: RRecipe)
    func didLoadMoreRecipes(with newIndexPaths: [IndexPath])
}

final class RHomeListViewViewModel: NSObject {
    
    public weak var delegate: RHomeListViewViewModelDelegate?
    
    private var isLoadingMoreRecipes = false
    
    private var recipes: [RRecipe] = [] {
        didSet {
            for recipe in recipes {
                let viewModel = RHomeCollectionViewCellViewModel(recipeName: recipe.title,
                                                                 recipeTime: recipe.readyInMinutes,
                                                                 recipeImageUrl: URL(string: recipe.image),
                                                                 isFavorite: false)
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RHomeCollectionViewCellViewModel] = []
    
    func fetchRecipes(for ingredient: String) {
        RService.shared.fetchRecipes(for: ingredient, random: true) { [weak self] results in
            self?.recipes = results
            self?.delegate?.didLoadInitialRecipes()
        }
    }
    
    // добавление дополнительных рецептов, когда пользователь прокрутит вниз
    public func fetchAddicationalRecipes() {
        guard !isLoadingMoreRecipes else {
            return
        }
        isLoadingMoreRecipes = true
        
        RService.shared.fetchRecipes(random: true) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            let moreResults = results
            
            let originalCount = strongSelf.recipes.count
            let newCount = moreResults.count
            let total = originalCount + newCount
            let startingIndex = total - newCount
            let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap {
                return IndexPath(row: $0, section: 0)
            }
            
            strongSelf.recipes.append(contentsOf: moreResults)
            DispatchQueue.main.async {
                strongSelf.delegate?.didLoadMoreRecipes(with: indexPathsToAdd)
                strongSelf.isLoadingMoreRecipes = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return true
    }
}

extension RHomeListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RHomeCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RHomeCollectionViewCell else {
            fatalError("Unsupported cell")
        }

        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let recipe = recipes[indexPath.row]
        delegate?.diSelectRecipes(recipe)
    }
    
    // Настройка нижнего колонтитула
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: RFooterLoadingCollectionReusableView.identifier,
                                                                           for: indexPath) as? RFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            // размер нижнего колонтитула становится = 0
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

// MARK: - ScrollView
// находимся ли мы внизу?
extension RHomeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !cellViewModels.isEmpty,
              !isLoadingMoreRecipes else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAddicationalRecipes()
            }
            timer.invalidate()
        }
    }
}

// MARK: - SearchBar
extension RHomeListViewViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        fetchRecipes(for: textSearched)
    }
}
