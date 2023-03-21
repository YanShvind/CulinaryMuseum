
import Foundation
import UIKit

protocol RHomeViewViewModelDelegate: AnyObject {
    func didLoadInitialRecipes()
}

final class RHomeViewViewModel: NSObject {
    
    public weak var delegate: RHomeViewViewModelDelegate?
    private var vegetarianRecipes: [RRecipe] = []
    
    let sections = MockData.shared.sections
    
    public func fetchVegetarianRecipes() {
        RService.shared.fetchRecipesByUrl(for: "https://api.spoonacular.com/recipes/complexSearch?apiKey=b7ca7001f0ea4607add6eec8873b6f6f&diet=vegetarian&addRecipeInformation=true&offset=\(Int.random(in: 0..<100))&number=10") { [weak self] results in
            guard let strongSelf = self else {
                return
            }
            strongSelf.vegetarianRecipes = results
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
        case .popularity(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionViewCell", for: indexPath) as? PopularityCollectionViewCell
            else { return UICollectionViewCell() }
            //cell.configure(imageName: popular[indexPath.row].image)
            return cell
            
        case .vegetarian(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VegetarianCollectionViewCell", for: indexPath) as? VegetarianCollectionViewCell
            else { return UICollectionViewCell() }
            cell.spinnerAnimating(animate: true)
            if !vegetarianRecipes.isEmpty {
                cell.spinnerAnimating(animate: false)
                RImageManager.shared.downloadImage(URL(string: vegetarianRecipes[indexPath.row].image)!) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            cell.configure(viewModel: self.vegetarianRecipes[indexPath.row], image: data)
                        }
                    case .failure(let error):
                        print("Error downloading image: \(error.localizedDescription)")
                    }
                }
            }
            return cell
            
        case .nutFree(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutFreeCollectionViewCell", for: indexPath) as? NutFreeCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure()
            return cell
            
        case .glutenFree(_):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GlutenFreeCollectionViewCell", for: indexPath) as? GlutenFreeCollectionViewCell
            else { return UICollectionViewCell() }
            cell.configure()
            return cell
            
        case .lowCalorie(_):
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
