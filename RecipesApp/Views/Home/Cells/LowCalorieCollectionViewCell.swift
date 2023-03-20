
import UIKit

final class LowCalorieCollectionViewCell: UICollectionViewCell {
    
    private let lowCalorieImageView: UIImageView = {
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
        addSubview(lowCalorieImageView)
        
        NSLayoutConstraint.activate([
            lowCalorieImageView.topAnchor.constraint(equalTo: topAnchor),
            lowCalorieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowCalorieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lowCalorieImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure() {
        
    }
}
