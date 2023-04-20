
import Foundation
import UIKit

final class RRecipeDetailViewViewModel: NSObject {
    
    private let recipe: RRecipe
    var ingredients: [String] = []
    var ingrName: [String] = []
    var ingrImage: [URL] = []
    
    init(recipe: RRecipe) {
        self.recipe = recipe
    }
    
    init(recipes: Recipes) {
        self.recipe = RRecipe(id: Int(recipes.id),
                              title: recipes.name!,
                              image: recipes.url!,
                              readyInMinutes: Int(recipes.time))
        self.ingredients = []
        super.init()
    }
    
    public var title: String {
        recipe.title.uppercased()
    }
    
    public func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: recipe.image) else {
              print("Error: invalid URL")
              return
          }
        RImageManager.shared.downloadImage(url,
                                           complection: completion)
    }
    
    public func fetchRecipeInformation(forId id: Int) {
        RService.shared.fetchRecipeInformation(for: id) { recipeInfo in
            if let ingredients = recipeInfo?.extendedIngredients {
                DispatchQueue.main.async { [weak self] in
                    self?.ingredients = ingredients.map { $0.original }
                    self?.ingrName = ingredients.map { $0.name }
                    self?.ingrImage = ingredients.map { URL(string: $0.image!)! }
                    print(ingredients.map { URL(string: $0.image!)! })
                }
            } else {
                print("Error: Unable to fetch recipe information")
            }
        }
    }
}

//MARK: - TableView
extension RRecipeDetailViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RRecipeDetailTableViewCell.cellIdentifier, for: indexPath) as! RRecipeDetailTableViewCell
        cell.backgroundColor = .secondarySystemBackground
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

//MARK: - CollectionView
extension RRecipeDetailViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RDetailIngredCollectionViewCell.identifier,
                                                            for: indexPath) as? RDetailIngredCollectionViewCell else {
            fatalError("Unable to dequeue SearchCollectionViewCell.")
        }
        cell.layer.cornerRadius = 17
        cell.layer.borderWidth = 1
        cell.backgroundColor = .systemBackground

        cell.configure(name: ingrName[indexPath.row],
                       image: ingrImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 4)
        return CGSize(width: width, height: 110)
    }
}
