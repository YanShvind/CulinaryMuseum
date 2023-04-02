
import UIKit

final class RFavoritesViewController: UIViewController {
    
    private let viewModel = RFavoriteViewViewModel()
    private let rFavoriteView = RFavoriteView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorites"
        self.view.backgroundColor = .systemBackground
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rFavoriteView.viewModel.recipes = RRecipeDataModel.shared.getAllRecipes()
        rFavoriteView.tableView.reloadData()
    }
    
    private func setUpView() {
        view.addSubview(rFavoriteView)
        NSLayoutConstraint.activate([
            rFavoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rFavoriteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rFavoriteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rFavoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RFavoritesViewController: RFavoriteViewDelegate {
    func rFavoriteView(_ recipeListView: RFavoriteView, didSelectRecipe recipe: Recipes) {
//        let viewModel = RRecipeDetailViewViewModel(recipe: recipe)
//        let detailVC = RRecipeDetailViewController(viewModel: viewModel)
//        //rFavoriteView.spinner.startAnimating()
//        rFavoriteView.isUserInteractionEnabled = false
//        viewModel.fetchRecipeInformation(forId: recipe.id)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//          //  self.rFavoriteView.spinner.stopAnimating()
//            self.rFavoriteView.isUserInteractionEnabled = true
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
    }
}
