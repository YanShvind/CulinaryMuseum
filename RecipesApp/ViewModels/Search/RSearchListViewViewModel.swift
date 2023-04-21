
import Foundation
import UIKit

protocol RSearchListViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
    func didSelectRecipes(_ recipe: RRecipe)
    func didLoadMoreRecipes()
}

final class RSearchListViewViewModel: NSObject {
    
    public weak var delegate: RSearchListViewViewModelDelegate?
    
    public var onDataUpdate: ((_ index: [IndexPath]) -> Void)? // наблюдатель для обновления ячейки
    var currentSearchText: String = ""

    private let timerInterval = 1.0
    private var timer: Timer?
    private var isLoadingMoreRecipes = false
    
    private var recipes: [RRecipe] = [] {
        didSet {
            cellViewModels = []
            for recipe in recipes {
                let viewModel = RCollectionViewCellViewModel(id: recipe.id,
                                                             recipeName: recipe.title,
                                                             recipeTime: recipe.readyInMinutes,
                                                             recipeImageUrl: URL(string: recipe.image),
                                                             isFavorite: false)
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    var cellViewModels: [RCollectionViewCellViewModel] = []
    
    public func fetchRecipes(for searchIngredient: String) {
        currentSearchText = searchIngredient
        RService.shared.fetchRecipes(for: searchIngredient, random: true) { [weak self] results in
            guard let strongSelf = self, !results.isEmpty else {
                return
            }
            strongSelf.recipes = results
            strongSelf.delegate?.didLoadInitialRecipes()
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return !isLoadingMoreRecipes && !recipes.isEmpty
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
        let recipe = recipes.first(where: { $0.id == cellViewModels[indexPath.row].id })
        guard let selectedRecipe = recipe else {
            return
        }
        delegate?.didSelectRecipes(selectedRecipe)
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
        guard shouldShowLoadMoreIndicator, !cellViewModels.isEmpty, !isLoadingMoreRecipes else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            guard !self.isLoadingMoreRecipes else {
                return
            }
            self.isLoadingMoreRecipes = true
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                
                RService.shared.fetchRecipes(for: self.currentSearchText, random: true) { [weak self] results in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.recipes.append(contentsOf: results)
                    strongSelf.isLoadingMoreRecipes = false
                    strongSelf.delegate?.didLoadMoreRecipes()
                }
            }
        }
    }
}

extension RSearchListViewViewModel: RSearchCollectionViewCellDelegate {
    func didTapHeartButton(in indexPath: IndexPath) {
        let favoriteVM = RFavoriteViewViewModel()
        let cell = cellViewModels[indexPath.row]
        if cell.isFavorite {
            return // элемент уже сохранен, не нужно сохранять его снова
        }
        cell.isFavorite = true
        onDataUpdate?([indexPath])
        cell.fetchImage { result in
            switch result {
            case .success(let imageData):
                let image = UIImage(data: imageData)
                let savedRecipe = RRecipeDataModel.shared.saveRecipe(url: cell.recipeImageUrl!.absoluteString,
                                                                     id: cell.id,
                                                                     name: cell.recipeName,
                                                                     time: cell.recipeTime,
                                                                     image: image!)
                favoriteVM.recipes.append(savedRecipe)
            case .failure(let error):
                print("Failed to fetch image: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - SearchBar
extension RSearchListViewViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.fetchRecipes(for: searchText)
        searchBar.endEditing(true)
    }
}
