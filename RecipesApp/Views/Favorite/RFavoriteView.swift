
import UIKit

protocol RFavoriteViewDelegate: AnyObject {
    func rFavoriteView(_ recipeListView: RFavoriteView,
                       didSelectRecipe recipe: Recipes)
}

final class RFavoriteView: UIView {
    
    public weak var delegate: RFavoriteViewDelegate?
    lazy var viewModel = RFavoriteViewViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemYellow
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        viewModel.delegate = self
        backgroundColor = .systemBackground
        tableViewSettings()
        addConstraints()
    }
    
    private func tableViewSettings() {
        tableView.register(RFavoriteTableViewCell.self, forCellReuseIdentifier: RFavoriteTableViewCell.identifier)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    private func addConstraints() {
        addSubviews(tableView, spinner)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RFavoriteView: RFavoriteViewViewModelelegate {
    func didSelectRecipes(_ recipe: Recipes) {
        delegate?.rFavoriteView(self, didSelectRecipe: recipe)
    }
}
