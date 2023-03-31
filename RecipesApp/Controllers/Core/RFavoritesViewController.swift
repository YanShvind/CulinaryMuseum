
import UIKit

final class RFavoritesViewController: UIViewController {
    
    private let rFavoriteView = RFavoriteView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorites"
        self.view.backgroundColor = .systemBackground
        setUpView()
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
