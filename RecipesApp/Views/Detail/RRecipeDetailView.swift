
import UIKit

protocol RRecipeDetailViewDelegate: AnyObject {
    func didInfoButtonTapped()
}

final class RRecipeDetailView: UIView {
    
    public weak var delegate: RRecipeDetailViewDelegate?
    private let viewModel: RRecipeDetailViewViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
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
        tableView.rowHeight = 30
        tableView.layer.cornerRadius = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Information", for: .normal)
        button.backgroundColor = .systemYellow
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    init(frame: CGRect, viewModel: RRecipeDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setView()
        addConstraints()
    }
    
    private func setView() {
        nameRecipeLabel.text = viewModel.title
        
        infoButton.addTarget(self,
                             action: #selector(infoButtonTapped),
                             for: .touchUpInside)
        
        tableView.register(RRecipeDetailTableViewCell.self,
                           forCellReuseIdentifier: RRecipeDetailTableViewCell.cellIdentifier)
        collectionView.register(RDetailIngredCollectionViewCell.self, forCellWithReuseIdentifier:
                                    RDetailIngredCollectionViewCell.identifier)
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
    @objc
    private func infoButtonTapped() {
        delegate?.didInfoButtonTapped()
    }
    
    public func configureView(with data: Data) {
        imageView.image = UIImage(data: data)
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RRecipeDetailView {
    private func addConstraints() {
        addSubviews(imageView, view)
        view.addSubviews(collectionView ,nameRecipeLabel, tableView, infoButton)
        
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
            
            collectionView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150),
            
            infoButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            infoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 200),
            infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
