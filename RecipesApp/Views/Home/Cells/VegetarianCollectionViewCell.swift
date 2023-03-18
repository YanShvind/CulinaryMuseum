
import UIKit

final class VegetarianCollectionViewCell: UICollectionViewCell {
    
    private let vegetarianImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "DDDD"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubviews(vegetarianImageView, nameLabel)
        
        NSLayoutConstraint.activate([
            vegetarianImageView.topAnchor.constraint(equalTo: topAnchor),
            vegetarianImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vegetarianImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vegetarianImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configure(title: String) {
        nameLabel.text = title
    }
}
