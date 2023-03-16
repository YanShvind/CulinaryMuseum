
import UIKit

final class PopularityCollectionViewCell: UICollectionViewCell {
    
    private let popularImageView: UIImageView = {
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
        addSubview(popularImageView)
        
        NSLayoutConstraint.activate([
            popularImageView.topAnchor.constraint(equalTo: topAnchor),
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
