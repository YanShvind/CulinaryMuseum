
import Foundation
import UIKit

protocol RHomeViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
}

final class RHomeViewViewModel: NSObject {
    
    public weak var delegate: RHomeViewViewModelDelegate?
    
    let sections = MockData.shared.sections
    
    //MARK: - Popularity
    private var popularRecipes: [RRecipe] = [] {
        didSet {
            popularRecipesCell = []
            for recipe in popularRecipes {
                let viewModel = RSearchCollectionViewCellViewModel(recipeName: recipe.title,
                                                                   recipeTime: recipe.readyInMinutes,
                                                                   recipeImageUrl: URL(string: recipe.image),
                                                                   isFavorite: false)
                if !popularRecipesCell.contains(viewModel){
                    popularRecipesCell.append(viewModel)
                }
            }
        }
    }
    private var popularRecipesCell: [RSearchCollectionViewCellViewModel] = []
    
    //MARK: - Vegetarian
    private var vegetarianRecipes: [RRecipe] = [] {
        didSet {
            vegetarianRecipesCell = []
            for recipe in vegetarianRecipes {
                let viewModel = RSearchCollectionViewCellViewModel(recipeName: recipe.title,
                                                                   recipeTime: recipe.readyInMinutes,
                                                                   recipeImageUrl: URL(string: recipe.image),
                                                                   isFavorite: false)
                if !vegetarianRecipesCell.contains(viewModel){
                    vegetarianRecipesCell.append(viewModel)
                }
            }
        }
    }
    private var vegetarianRecipesCell: [RSearchCollectionViewCellViewModel] = []

    public func fetchRecipes() {
        // проверяем, чтобы запросы выполнялись последовательно, а не параллельно
        let group = DispatchGroup()
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.vegetarianRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.vegetarianRecipes = results
            group.leave()
        }
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.popularRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.popularRecipes = results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.delegate?.didLoadInitialRecipes()
        }
    }
}

extension RHomeViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section]{
        case .popularity(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionViewCell", for: indexPath) as? PopularityCollectionViewCell
            else { return UICollectionViewCell() }
            cell.popularView.spinnerAnimating(animate: true)
            if !popularRecipesCell.isEmpty {
                DispatchQueue.main.async {
                    cell.configure(viewModel: self.popularRecipesCell[indexPath.row])
                }
            }
            return cell
            
        case .vegetarian(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VegetarianCollectionViewCell", for: indexPath) as? VegetarianCollectionViewCell
            else { return UICollectionViewCell() }
            cell.vegetarianView.spinnerAnimating(animate: true)
            if !vegetarianRecipesCell.isEmpty {
                DispatchQueue.main.async {
                    cell.configure(viewModel: self.vegetarianRecipesCell[indexPath.row])
                }
            }
            return cell
            
        case .nutFree(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutFreeCollectionViewCell", for: indexPath) as? NutFreeCollectionViewCell
            else { return UICollectionViewCell() }
            //cell.configure(viewModel: <#RRecipe#>, image: <#Data#>)
            return cell
            
        case .glutenFree(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlutenFreeCollectionViewCell", for: indexPath) as? GlutenFreeCollectionViewCell
            else { return UICollectionViewCell() }
            //cell.configure(viewModel: <#RRecipe#>, image: <#Data#>)
            return cell
            
        case .lowCalorie(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LowCalorieCollectionViewCell", for: indexPath) as? LowCalorieCollectionViewCell
            else { return UICollectionViewCell() }
            //cell.configure(viewModel: <#RRecipe#>, image: <#Data#>)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
