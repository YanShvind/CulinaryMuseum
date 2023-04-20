
import UIKit

final class RDetailIngredCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = .label
        label.backgroundColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "RDetailIngredCollectionViewCell"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addConstraints()
    }
    
    private func addConstraints() {
        addSubviews(imageView, nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name: String, image: URL?) {
        self.nameLabel.text = name
        
        guard let url = image else {
            print("Error: invalid URL")
            return
        }
        
        let imageUrl: URL
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           components.scheme == "https" {
            imageUrl = components.url!
        } else {
            let urlString = "https://spoonacular.com/cdn/ingredients_100x100/\(url.absoluteString)"
            imageUrl = URL(string: urlString)!
        }
        
        RImageManager.shared.downloadImage(imageUrl) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print("Error loading image:", error.localizedDescription)
            }
        }
    }
}
