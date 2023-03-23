
import UIKit

final class VegetarianCollectionViewCell: UICollectionViewCell {
    
    lazy var vegetarianView = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func configure(viewModel: RRecipe, image: Data) {
        vegetarianView.nameLabel.text = viewModel.title
        vegetarianView.imageView.image = UIImage(data: image)
        vegetarianView.readyInTimeLabel.text = "\(viewModel.readyInMinutes) min."
    }
    
    private func setUpView() {
        addSubview(vegetarianView)
        NSLayoutConstraint.activate([
            vegetarianView.topAnchor.constraint(equalTo: topAnchor),
            vegetarianView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vegetarianView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vegetarianView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
