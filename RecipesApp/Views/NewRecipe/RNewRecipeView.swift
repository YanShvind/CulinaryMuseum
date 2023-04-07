
import UIKit

final class RNewRecipeView: UIView {
    
    private let viewModel = RNewRecipeViewViewModel()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let addCellButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.tintColor = .systemBackground
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        addCellButton.addTarget(self, action: #selector(addRecipeButtonPressed),
                                for: .touchUpInside)
        tableViewSettings()
        addConstraints()
    }
    
    private func tableViewSettings() {
        tableView.register(RNewRecipeTableViewCell.self,
                           forCellReuseIdentifier: RNewRecipeTableViewCell.identifier)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    @objc private func addRecipeButtonPressed() {
        delegate?.didAddNewRecipePressed()
    }
    
    private func addConstraints() {
        addSubviews(tableView, addCellButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            addCellButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addCellButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            addCellButton.widthAnchor.constraint(equalToConstant: 40),
            addCellButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
