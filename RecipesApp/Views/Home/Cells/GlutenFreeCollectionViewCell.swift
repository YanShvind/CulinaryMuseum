
import UIKit

final class GlutenFreeCollectionViewCell: UICollectionViewCell {
    
    private let vegetarianImageView: UIImageView = {
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
        addSubview(vegetarianImageView)
        
        NSLayoutConstraint.activate([
            vegetarianImageView.topAnchor.constraint(equalTo: topAnchor),
            vegetarianImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vegetarianImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vegetarianImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure() {
        
    }
}
