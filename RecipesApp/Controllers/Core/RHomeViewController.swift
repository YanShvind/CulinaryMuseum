
import UIKit

final class RHomeViewController: UIViewController {
    
    private let rHomeView = RHomeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        self.view.backgroundColor = .systemBackground
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
