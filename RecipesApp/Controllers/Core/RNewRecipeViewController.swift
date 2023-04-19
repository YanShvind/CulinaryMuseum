
import UIKit

final class RNewRecipeViewController: UIViewController {
    
    private let rNewRecipeView = RNewRecipeView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rNewRecipeView.viewModel.recipes = RNewRecipeDataModel.shared.getAllRecipes()
        rNewRecipeView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Recipes"
        view.backgroundColor = .systemBackground
        rNewRecipeView.delegate = self
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rNewRecipeView)
        NSLayoutConstraint.activate([
            rNewRecipeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rNewRecipeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rNewRecipeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rNewRecipeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RNewRecipeViewController: RNewRecipeViewViewModelDelegate {
    func didTapNewRecipeButton() {
        let vc = RAddRecipeViewController()
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }
}
