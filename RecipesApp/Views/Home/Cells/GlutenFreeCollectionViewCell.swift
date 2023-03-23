
import UIKit

final class GlutenFreeCollectionViewCell: UICollectionViewCell {
    
    private let glutenFreeVeiw = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
        
    public func configure(viewModel: RRecipe, image: Data) {

    }
    
    private func setUpView() {
        addSubview(glutenFreeVeiw)
        NSLayoutConstraint.activate([
            glutenFreeVeiw.topAnchor.constraint(equalTo: topAnchor),
            glutenFreeVeiw.leadingAnchor.constraint(equalTo: leadingAnchor),
            glutenFreeVeiw.trailingAnchor.constraint(equalTo: trailingAnchor),
            glutenFreeVeiw.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
