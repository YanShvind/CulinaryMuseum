
import UIKit

final class RSearchViewController: UIViewController {
    
    private let rSearchView = RSearchListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        self.view.backgroundColor = .systemBackground
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
    func rHomeListView(_ recipeListView: RSearchListView, didSelectRecipe recipe: RRecipe) {
        let viewModel = RHomeDetailViewViewModel(recipe: recipe)
        let detailVC = RRecipeDetailViewController(viewModel: viewModel)
        print(recipe.readyInMinutes)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
