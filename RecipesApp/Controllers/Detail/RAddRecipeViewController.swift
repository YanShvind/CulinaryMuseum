
import UIKit

final class RAddRecipeViewController: UIViewController {
    
    private let rAddNewRecipeView = RAddNewRecipeView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create your Recipe"
        rAddNewRecipeView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(rAddNewRecipeView)
        NSLayoutConstraint.activate([
            rAddNewRecipeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rAddNewRecipeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rAddNewRecipeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rAddNewRecipeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RAddRecipeViewController: RAddNewRecipeViewDelegate {
    func didTappedImageButton() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let pop = RPopupView()
            self.view.addSubview(pop)
        }
    }
}
