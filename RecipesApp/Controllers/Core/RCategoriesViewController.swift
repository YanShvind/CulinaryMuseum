
import UIKit

final class RCategoriesViewController: UIViewController {
        
    private let rCategoryView = RCategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        rCategoryView.viewModel.delegate = self
        self.view.backgroundColor = .systemBackground
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rCategoryView)
        NSLayoutConstraint.activate([
            rCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rCategoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rCategoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rCategoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RCategoriesViewController: RCategoryViewViewModelDelegate {
    func rCategoryViewViewModel(_ viewModel: RCategoryViewViewModel, didSelectCategory category: String) {
        let searchVC = RSearchViewController()
        searchVC.category = category
        rCategoryView.spinner.startAnimating()
        rCategoryView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.rCategoryView.spinner.stopAnimating()
            self.rCategoryView.isUserInteractionEnabled = true
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}
