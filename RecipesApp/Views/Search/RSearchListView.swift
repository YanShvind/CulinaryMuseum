
import UIKit

protocol RSearchListViewDelegate: AnyObject {
    func rSearchListView(_ recipeListView: RSearchListView,
                       didSelectRecipe recipe: RRecipe)
}

final class RSearchListView: UIView {
    
    public weak var delegate: RSearchListViewDelegate?
    
    private let viewModel = RSearchListViewViewModel()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.textColor = .label
        searchBar.barStyle = .default
        searchBar.placeholder = "Enter ingredients"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RSearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: RSearchCollectionViewCell.cellIdentifier)
        collectionView.register(RFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(searchBar, collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        viewModel.fetchRecipes(for: "")
        viewModel.delegate = self
        setUpCollectionView()
    }
    
    // меняем стиль searchBar при переходе на темную тему
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            searchBar.barStyle = traitCollection.userInterfaceStyle == .dark ? .black : .default
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        searchBar.delegate = viewModel
    }
}

extension RSearchListView: RSearchListViewViewModelDelegate {
    func didLoadMoreRecipes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func diSelectRecipes(_ recipe: RRecipe) {
        delegate?.rSearchListView(self, didSelectRecipe: recipe)
    }
    
    func didLoadInitialRecipes() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1
            }
        }
    }
}
