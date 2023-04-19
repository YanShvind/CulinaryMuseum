
import UIKit

final class RNewRecipeTableViewCell: UITableViewCell {
    
    static let identifier = "RNewRecipeTableViewCell"
    
    lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        addSubviews(recipeImageView, nameLabel)
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            recipeImageView.widthAnchor.constraint(equalToConstant: 170),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    public func configure(name: String, image: Data) {
        self.nameLabel.text = name
        self.recipeImageView.image = UIImage(data: image)
    }
}
