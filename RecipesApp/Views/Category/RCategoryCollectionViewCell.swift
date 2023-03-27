
import UIKit

final class RCategoryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RCategoryCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "breakfast")
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "breakfast"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        addConstraints()
    }
    
    private func setUpView() {
        contentView.backgroundColor = UIColor(named: "lightYellow")
        clipsToBounds = true
        self.layer.cornerRadius = 20
        
        addSubviews(imageView, nameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
        
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(nameLabelText: String, categoryImage: UIImage) {
        nameLabel.text = nameLabelText
        imageView.image = categoryImage
    }
}
