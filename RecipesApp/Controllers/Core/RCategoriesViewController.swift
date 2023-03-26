
import UIKit

final class RCategoriesViewController: UIViewController {
    
    private let rCategoryView = RCategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
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
