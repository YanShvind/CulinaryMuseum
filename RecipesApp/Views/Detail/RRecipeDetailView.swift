
import UIKit

final class RRecipeDetailView: UIView {
    
    private let viewModel: RRecipeDetailViewViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let view: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemYellow
        tableView.rowHeight = 30
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Information", for: .normal)
        button.backgroundColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    init(frame: CGRect, viewModel: RRecipeDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        nameRecipeLabel.text = viewModel.title
        
        tableView.register(RRecipeDetailTableViewCell.self, forCellReuseIdentifier: RRecipeDetailTableViewCell.cellIdentifier)
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(with data: Data) {
        imageView.image = UIImage(data: data)
        tableView.reloadData()
    }
}

extension RRecipeDetailView {
    private func addConstraints() {
        addSubviews(imageView, view)
        view.addSubviews(nameRecipeLabel, tableView, infoButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            view.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -200),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameRecipeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            nameRecipeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameRecipeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameRecipeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150),
            
            infoButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            infoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 200),
            infoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
