
import Foundation
import UIKit

protocol RSearchListViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
    func didSelectRecipes(_ recipe: RRecipe)
    func didLoadMoreRecipes(with newIndexPaths: [IndexPath])
}

final class RSearchListViewViewModel: NSObject {
    
    public weak var delegate: RSearchListViewViewModelDelegate?
    
    public var onDataUpdate: ((_ index: [IndexPath]) -> Void)? // наблюдатель для обновления ячейки
    private var currentSearchText: String = ""
    
    private var isLoadingMoreRecipes = false
    
    private var recipes: [RRecipe] = [] {
        didSet {
            cellViewModels = []
            for recipe in recipes {
                let viewModel = RCollectionViewCellViewModel(recipeName: recipe.title,
                                                                   recipeTime: recipe.readyInMinutes,
                                                                   recipeImageUrl: URL(string: recipe.image),
                                                                   isFavorite: false)
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RCollectionViewCellViewModel] = []
    
    public func fetchRecipes(for searchIngredient: String) {
        currentSearchText = searchIngredient
        RService.shared.fetchRecipes(for: searchIngredient, random: true) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.recipes = results
            strongSelf.delegate?.didLoadInitialRecipes()
        }
    }
    
    // добавление дополнительных рецептов, когда пользователь прокрутит вниз
    public func fetchAddicationalRecipes() {
        guard !isLoadingMoreRecipes else {
            return
        }
        isLoadingMoreRecipes = true
        
        RService.shared.fetchRecipes(for: currentSearchText, random: true) { [weak self] results in
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

extension RSearchListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RSearchCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RSearchCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.delegate = self
        cell.index = indexPath
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
        delegate?.didSelectRecipes(recipe)
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
extension RSearchListViewViewModel: UIScrollViewDelegate {
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

extension RSearchListViewViewModel: RSearchCollectionViewCellDelegate {
    func didTapHeartButton(in indexPath: IndexPath) {
        let cell = cellViewModels[indexPath.row]
        cell.isFavorite = !cell.isFavorite
        onDataUpdate?([indexPath])
        print(recipes[indexPath.row].id) // ид по которому нужно сохранять рецепты
    }
}

// MARK: - SearchBar
extension RSearchListViewViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.fetchRecipes(for: searchText)
    }
}
