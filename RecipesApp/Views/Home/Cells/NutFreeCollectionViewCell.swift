
import UIKit

final class NutFreeCollectionViewCell: UICollectionViewCell {
    
    private let nutFreeVeiw = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
        
    public func configure(viewModel: RRecipe, image: Data) {
        
    }
    
    private func setUpView() {
        addSubview(nutFreeVeiw)
        NSLayoutConstraint.activate([
            nutFreeVeiw.topAnchor.constraint(equalTo: topAnchor),
            nutFreeVeiw.leadingAnchor.constraint(equalTo: leadingAnchor),
            nutFreeVeiw.trailingAnchor.constraint(equalTo: trailingAnchor),
            nutFreeVeiw.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
