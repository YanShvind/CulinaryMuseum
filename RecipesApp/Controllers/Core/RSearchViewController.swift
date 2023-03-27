
import UIKit

final class RSearchViewController: UIViewController {
    
    private let rSearchView = RSearchListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        self.view.backgroundColor = .systemBackground
        self.rSearchView.hideKeyboardWhenTappedAround()
        rSearchView.delegate = self
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rSearchView)
        NSLayoutConstraint.activate([
            rSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rSearchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RSearchViewController: RSearchListViewDelegate {
    func rSearchListView(_ recipeListView: RSearchListView, didSelectRecipe recipe: RRecipe) {
        let viewModel = RRecipeDetailViewViewModel(recipe: recipe)
        let detailVC = RRecipeDetailViewController(viewModel: viewModel)
        rSearchView.spinner.startAnimating()
        rSearchView.isUserInteractionEnabled = false
        viewModel.fetchRecipeInformation(forId: recipe.id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rSearchView.spinner.stopAnimating()
            self.rSearchView.isUserInteractionEnabled = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
