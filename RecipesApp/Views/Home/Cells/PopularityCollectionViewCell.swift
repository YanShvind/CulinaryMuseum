
import UIKit

final class PopularityCollectionViewCell: UICollectionViewCell {
    
    private let popularImageView: UIImageView = {
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
        addSubviews(popularImageView, nameLabel)
        
        NSLayoutConstraint.activate([
            popularImageView.topAnchor.constraint(equalTo: topAnchor),
            popularImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    public func configure(imageName: String) {
    }
}
