
import UIKit

final class RHomeView: UIView {
    
    private let viewModel = RHomeViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.fetchRecipes()
        viewModel.delegate = self
        createCollectionView()
        addConstraints()
    }
    
    private func createCollectionView() {
        collectionView.register(PopularityCollectionViewCell.self,
                                forCellWithReuseIdentifier: "PopularityCollectionViewCell")
        collectionView.register(VegetarianCollectionViewCell.self,
                                forCellWithReuseIdentifier: "VegetarianCollectionViewCell")
        collectionView.register(NutFreeCollectionViewCell.self,
                                forCellWithReuseIdentifier: "NutFreeCollectionViewCell")
        collectionView.register(GlutenFreeCollectionViewCell.self,
                                forCellWithReuseIdentifier: "GlutenFreeCollectionViewCell")
        collectionView.register(LowCalorieCollectionViewCell.self,
                                forCellWithReuseIdentifier: "LowCalorieCollectionViewCell")
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderCollectionReusableView")
        collectionView.collectionViewLayout = createLayout()
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}

//MARK: - Create Layout
extension RHomeView {
    private func createLayout () -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.viewModel.sections[sectionIndex]
            switch section {
            case .popularity(_):
                return self.createPopularSection()
            case .vegetarian(_):
                return self.createPopularSection()
            case .nutFree(_):
                return self.createPopularSection()
            case .glutenFree(_):
                return self.createPopularSection()
            case .lowCalorie(_):
                return self.createPopularSection()
            }
        }
    }
    
    private func createLayoutSection (group: NSCollectionLayoutGroup,
                                      behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                      interGroupSpacing: CGFloat,
                                      supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                      contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection (group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    private func createPopularSection () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight (1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:.init(widthDimension: .fractionalWidth(0.8),
                                                                        heightDimension: .fractionalHeight(0.37)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 15,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    // настройка заголовка
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(40)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension RHomeView: RHomeViewViewModelDelegate {
    func didLoadInitialRecipes() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
