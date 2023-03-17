
import UIKit

final class VegetarianCollectionViewCell: UICollectionViewCell {
    
    private let veganImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        addSubview(veganImageView)
        
        NSLayoutConstraint.activate([
            veganImageView.topAnchor.constraint(equalTo: topAnchor),
            veganImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            veganImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            veganImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure() {
        
    }
}
