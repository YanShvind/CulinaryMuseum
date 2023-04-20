
import UIKit

protocol RSearchListViewDelegate: AnyObject {
    func rSearchListView(_ recipeListView: RSearchListView,
                       didSelectRecipe recipe: RRecipe)
}

final class RSearchListView: UIView {
    
    public weak var delegate: RSearchListViewDelegate?
    lazy var viewModel = RSearchListViewViewModel()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.textColor = .label
        searchBar.barStyle = .default
        searchBar.placeholder = "Enter ingredient"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemYellow
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
     lazy var collectionView: UICollectionView = {
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

        updateCell()
        spinner.startAnimating()
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
    
    private func updateCell() {
        // Обновление ячейки коллекции для добавления в избранное
        viewModel.onDataUpdate = { [weak self] index in
            DispatchQueue.main.async {
                self?.collectionView.performBatchUpdates({
                    let indexPathsToUpdate = index
                    self?.collectionView.reloadItems(at: indexPathsToUpdate)
                }, completion: nil)
            }
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
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: newIndexPaths)
        }, completion: nil)
    }
    
    func didSelectRecipes(_ recipe: RRecipe) {
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
