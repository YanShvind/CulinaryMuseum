
import Foundation
import UIKit

protocol RHomeViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
}

final class RHomeViewViewModel: NSObject {
    
    public weak var delegate: RHomeViewViewModelDelegate?
    
    var recipes: [RRecipe] = []
    
    struct ListItem {
        let title: String
        let image: String
    }
    
    enum ListSection {
        case populatity([ListItem])
        case vegetarian([ListItem])
        case nutFree([ListItem])
        case glutenFree([ListItem])
        case lowCalorie([ListItem])
        
        var items: [ListItem] {
            switch self {
            case .populatity(let items),
                    .vegetarian(let items),
                    .nutFree(let items),
                    .glutenFree(let items),
                    .lowCalorie(let items):
                return items
            }
        }
        
        var count: Int {
            items.count
        }
        
        var title: String {
            switch self {
            case .populatity(_):
                return "Populatity"
            case .vegetarian(_):
                return "Vegetarian"
            case .nutFree(_):
                return "Nut Free"
            case .glutenFree(_):
                return "Gluten Free"
            case .lowCalorie(_):
                return "Low Calorie"
            }
        }
    }
    
    private var popularity: ListSection {
        .populatity([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var vegetarian: ListSection {
        .vegetarian([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var nutFree: ListSection {
        .nutFree([.init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: "")
        ])
    }
    
    private var glutenFree: ListSection {
        .glutenFree([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var lowCalorie: ListSection {
        .lowCalorie([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    var sections: [ListSection] {
        [popularity, vegetarian, nutFree, glutenFree, lowCalorie]
    }
    
    public func fetchVegetarianRecipes() {
        RService.shared.fetchRecipesByUrl(for: "https://api.spoonacular.com/recipes/complexSearch?apiKey=b7ca7001f0ea4607add6eec8873b6f6f&diet=vegetarian&addRecipeInformation=true&number=10") { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.recipes = results
            strongSelf.delegate?.didLoadInitialRecipes()
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
        case .populatity(let popular):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionViewCell", for: indexPath) as? PopularityCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure(imageName: popular[indexPath.row].image)
            return cell
            
        case .vegetarian(let vegetarian):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VegetarianCollectionViewCell", for: indexPath) as? VegetarianCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure(title: self.recipes[indexPath.row].title)
            
            return cell
            
        case .nutFree(let nutFree):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutFreeCollectionViewCell", for: indexPath) as? NutFreeCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure()
            return cell
            
        case .glutenFree(let glutenFree):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlutenFreeCollectionViewCell", for: indexPath) as? GlutenFreeCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure()
            return cell
            
        case .lowCalorie(let lowCalorie):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LowCalorieCollectionViewCell", for: indexPath) as? LowCalorieCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure()
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
