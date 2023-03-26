
import Foundation
import UIKit

protocol RHomeViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
    func didSelectRecipes(_ recipe: RRecipe)
}

final class RHomeViewViewModel: NSObject {
    
    public weak var delegate: RHomeViewViewModelDelegate?
    
    let sections = MockData.shared.sections
    
    private func convertToCollectionViewCellViewModels(recipes: [RRecipe]) -> [RCollectionViewCellViewModel] {
        var cellViewModels: [RCollectionViewCellViewModel] = []
        for recipe in recipes {
            let viewModel = RCollectionViewCellViewModel(recipeName: recipe.title,
                                                         recipeTime: recipe.readyInMinutes,
                                                         recipeImageUrl: URL(string: recipe.image),
                                                         isFavorite: false)
            if !cellViewModels.contains(viewModel) {
                cellViewModels.append(viewModel)
            }
        }
        return cellViewModels
    }
    
    //MARK: - Popularity
    private var popularRecipes: [RRecipe] = [] {
        didSet {
            popularRecipesCell = convertToCollectionViewCellViewModels(recipes: popularRecipes)
        }
    }
    private var popularRecipesCell: [RCollectionViewCellViewModel] = []
    
    //MARK: - Vegetarian
    private var vegetarianRecipes: [RRecipe] = [] {
        didSet {
            vegetarianRecipesCell = convertToCollectionViewCellViewModels(recipes: vegetarianRecipes)
        }
    }
    private var vegetarianRecipesCell: [RCollectionViewCellViewModel] = []
    
    //MARK: - Short Cooking Time
    private var shortCookingTimeRecipes: [RRecipe] = [] {
        didSet {
            shortCookingTimeRecipesCell = convertToCollectionViewCellViewModels(recipes: shortCookingTimeRecipes)
        }
    }
    private var shortCookingTimeRecipesCell: [RCollectionViewCellViewModel] = []
    
    //MARK: - Healthy
    private var healthyRecipes: [RRecipe] = [] {
        didSet {
            healthyRecipesCell = convertToCollectionViewCellViewModels(recipes: healthyRecipes)
        }
    }
    private var healthyRecipesCell: [RCollectionViewCellViewModel] = []
    
    //MARK: - Low Calorie
    private var lowCalorieRecipes: [RRecipe] = [] {
        didSet {
            lowCalorieRecipesCell = convertToCollectionViewCellViewModels(recipes: lowCalorieRecipes)
        }
    }
    private var lowCalorieRecipesCell: [RCollectionViewCellViewModel] = []
    
    //MARK: - Requests
    public func fetchRecipes() {
        // проверяем, чтобы запросы выполнялись последовательно, а не параллельно
        // тем самым избегаем дублирование и мигание
        let group = DispatchGroup()
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.popularRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.popularRecipes = results
            group.leave()
        }
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.vegetarianRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.vegetarianRecipes = results
            group.leave()
        }
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.shortCookingTimePath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.shortCookingTimeRecipes = results
            group.leave()
        }
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.healthyRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.healthyRecipes = results
            group.leave()
        }
        
        group.enter()
        RService.shared.fetchRecipesByUrl(for: Constants.shared.lowCalorieRecipesPath) { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.lowCalorieRecipes = results
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionViewCell", for: indexPath) as? RPopularityCollectionViewCell
            else { return UICollectionViewCell() }
            cell.popularView.spinnerAnimating(animate: true)
            if !popularRecipesCell.isEmpty {
                cell.configure(viewModel: self.popularRecipesCell[indexPath.row])
            }
            return cell
            
        case .vegetarian(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VegetarianCollectionViewCell", for: indexPath) as? RVegetarianCollectionViewCell
            else { return UICollectionViewCell() }
            cell.vegetarianView.spinnerAnimating(animate: true)
            if !vegetarianRecipesCell.isEmpty {
                cell.configure(viewModel: self.vegetarianRecipesCell[indexPath.row])
            }
            return cell
            
        case .shortCookingTime(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortCookingTimeCollectionViewCell", for: indexPath) as? RShortCookingTimeCollectionViewCell
            else { return UICollectionViewCell() }
            cell.shortCookingTimeView.spinnerAnimating(animate: true)
            if !shortCookingTimeRecipesCell.isEmpty {
                cell.configure(viewModel: self.shortCookingTimeRecipesCell[indexPath.row])
            }
            return cell
            
        case .healthy(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthyCollectionViewCell", for: indexPath) as? RHealthyCollectionViewCell
            else { return UICollectionViewCell() }
            if !healthyRecipesCell.isEmpty {
                cell.configure(viewModel: self.healthyRecipesCell[indexPath.row])
            }
            return cell
            
        case .lowCalorie(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LowCalorieCollectionViewCell", for: indexPath) as? RLowCalorieCollectionViewCell
            else { return UICollectionViewCell() }
            cell.lowCalorieView.spinnerAnimating(animate: true)
            if !lowCalorieRecipesCell.isEmpty {
                cell.configure(viewModel: self.lowCalorieRecipesCell[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section]{
        case .popularity(_):
            let recipe = popularRecipes[indexPath.row]
            delegate?.didSelectRecipes(recipe)

        case .vegetarian(_):
            let recipe = vegetarianRecipes[indexPath.row]
            delegate?.didSelectRecipes(recipe)

        case .shortCookingTime(_):
            let recipe = shortCookingTimeRecipes[indexPath.row]
            delegate?.didSelectRecipes(recipe)

        case .healthy(_):
            let recipe = healthyRecipes[indexPath.row]
            delegate?.didSelectRecipes(recipe)

        case .lowCalorie(_):
            let recipe = lowCalorieRecipes[indexPath.row]
            delegate?.didSelectRecipes(recipe)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! RHeaderCollectionReusableView
            header.configureHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
