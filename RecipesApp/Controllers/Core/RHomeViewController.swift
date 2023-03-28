
import UIKit

final class RHomeViewController: UIViewController {
    
    private let rHomeView = RHomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        view.backgroundColor = .systemBackground
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

extension RHomeViewController: RHomeViewDelegate {
    func rHomeView(_ recipeListView: RHomeView, didSelectRecipe recipe: RRecipe) {
        let viewModel = RRecipeDetailViewViewModel(recipe: recipe)
        let detailVC = RRecipeDetailViewController(viewModel: viewModel)
        rHomeView.spinner.startAnimating()
        rHomeView.isUserInteractionEnabled = false
        viewModel.fetchRecipeInformation(forId: recipe.id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rHomeView.spinner.stopAnimating()
            self.rHomeView.isUserInteractionEnabled = true
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
