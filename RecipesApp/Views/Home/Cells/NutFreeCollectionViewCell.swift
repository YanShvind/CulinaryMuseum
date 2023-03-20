
import UIKit

final class NutFreeCollectionViewCell: UICollectionViewCell {
    
    private let nutFreeImageView: UIImageView = {
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
        addSubview(nutFreeImageView)
        
        NSLayoutConstraint.activate([
            nutFreeImageView.topAnchor.constraint(equalTo: topAnchor),
            nutFreeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nutFreeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nutFreeImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure() {
        
    }
}
