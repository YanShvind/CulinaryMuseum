
import UIKit

final class LowCalorieCollectionViewCell: UICollectionViewCell {
    
    private let lowCalorieView = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    private func setUpView() {
        addSubview(lowCalorieView)
        NSLayoutConstraint.activate([
            lowCalorieView.topAnchor.constraint(equalTo: topAnchor),
            lowCalorieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowCalorieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lowCalorieView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func configure(viewModel: RRecipe, image: Data) {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
