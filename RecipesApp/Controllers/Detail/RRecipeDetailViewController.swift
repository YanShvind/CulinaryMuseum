
import Foundation
import UIKit

final class RRecipeDetailViewController: UIViewController {
    
    private let rRecipeDetailView: RRecipeDetailView
    private let viewModel: RRecipeDetailViewViewModel
    
    init(viewModel: RRecipeDetailViewViewModel){
        self.viewModel = viewModel
        self.rRecipeDetailView = RRecipeDetailView(frame: .zero, viewModel: viewModel)
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        rRecipeDetailView.delegate = self
        downloadImage()
        setUpView()
    }
    
    private func downloadImage() {
        viewModel.downloadImage { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.rRecipeDetailView.configureView(with: data)
                }
            case .failure(let error):
                print("Error downloading image: \(error.localizedDescription)")
            }
        }
    }
    
    private func setUpView() {
        view.addSubview(rRecipeDetailView)
        NSLayoutConstraint.activate([
            rRecipeDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rRecipeDetailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rRecipeDetailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            rRecipeDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension RRecipeDetailViewController: RRecipeDetailViewDelegate {
    func didInfoButtonTapped() {
        let name = viewModel.recipe.title.replacingOccurrences(of: " ", with: "-")
        let id = viewModel.recipe.id
        if let url = URL(string: "https://spoonacular.com/recipes/\(name)-\(id)") {
            UIApplication.shared.open(url)
        }
    }
}
