
import UIKit

final class GlutenFreeCollectionViewCell: UICollectionViewCell {
    
    private let glutenFreeImageView: UIImageView = {
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
        addSubview(glutenFreeImageView)
        
        NSLayoutConstraint.activate([
            glutenFreeImageView.topAnchor.constraint(equalTo: topAnchor),
            glutenFreeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            glutenFreeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            glutenFreeImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure() {
        
    }
}
