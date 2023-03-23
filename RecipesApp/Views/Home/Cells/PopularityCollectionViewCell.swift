
import UIKit

final class PopularityCollectionViewCell: UICollectionViewCell {
    
    private let popularView = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func configure(viewModel: RRecipe, image: Data) {
        
    }
    
    private func setUpView() {
        addSubview(popularView)
        NSLayoutConstraint.activate([
            popularView.topAnchor.constraint(equalTo: topAnchor),
            popularView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
