
import Foundation
import UIKit

final class RRecipeDetailViewController: UIViewController {
    private let viewModel: RHomeDetailViewViewModel
    
    init(viewModel: RHomeDetailViewViewModel){
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
}
