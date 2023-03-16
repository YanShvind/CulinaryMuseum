
import UIKit

final class RHomeView: UIView {
    
    private let viewModel: RHomeViewViewModel
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(frame: CGRect, viewModel: RHomeViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        createCollectionView()
        addConstraints()
    }
    
    private func createCollectionView() {
        collectionView.register(PopularityCollectionViewCell.self, forCellWithReuseIdentifier: "PopularityCollectionViewCell")
        collectionView.register(VegetarianCollectionViewCell.self, forCellWithReuseIdentifier: "VegetarianCollectionViewCell")
        
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
