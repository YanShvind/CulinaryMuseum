
import UIKit

final class RHomeViewController: UIViewController {
    
    private let rHomeView = RHomeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        self.view.backgroundColor = .systemBackground
        rHomeView.delegate = self
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rHomeView)
        NSLayoutConstraint.activate([
            rHomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rHomeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rHomeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rHomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RHomeViewController: RHomeListViewDelegate {
    func rHomeListView(_ recipeListView: RHomeListView, didSelectRecipe recipe: RRecipe) {
        let viewModel = RRecipeDetailViewViewModel(recipe: recipe)
        let detailVC = RRecipeDetailViewController(viewModel: viewModel)
        print(recipe.readyInMinutes)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
