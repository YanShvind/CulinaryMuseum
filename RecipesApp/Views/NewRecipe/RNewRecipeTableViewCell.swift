
import UIKit

protocol RNewRecipeTableViewCellDelegate: AnyObject {
    func didDescriptionButtonTapped(indexPath: IndexPath)
}

final class RNewRecipeTableViewCell: UITableViewCell {
    
    public weak var delegate: RNewRecipeTableViewCellDelegate?
    static let identifier = "RNewRecipeTableViewCell"
    var index: IndexPath?
    
    lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
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
    
    private let viewBackgroundD: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        descriptionButton.addTarget(self,
                                    action: #selector(descriptionButtonTapped),
                                    for: .touchUpInside)
        addConstraints()
    }
    
    @objc
    private func descriptionButtonTapped() {
        guard let index = index else { return }
        delegate?.didDescriptionButtonTapped(indexPath: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        contentView.addSubviews(recipeImageView, nameLabel, viewBackgroundD)
        viewBackgroundD.addSubview(descriptionButton)
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            recipeImageView.widthAnchor.constraint(equalToConstant: 170),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            viewBackgroundD.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor, constant: 7),
            viewBackgroundD.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 7),
            viewBackgroundD.widthAnchor.constraint(equalToConstant: 30),
            viewBackgroundD.heightAnchor.constraint(equalToConstant: 35),
            
            descriptionButton.topAnchor.constraint(equalTo: viewBackgroundD.topAnchor),
            descriptionButton.leadingAnchor.constraint(equalTo: viewBackgroundD.leadingAnchor),
            descriptionButton.bottomAnchor.constraint(equalTo: viewBackgroundD.bottomAnchor),
            descriptionButton.trailingAnchor.constraint(equalTo: viewBackgroundD.trailingAnchor)
        ])
    }
    
    public func configure(name: String, image: Data) {
        self.nameLabel.text = name
        self.recipeImageView.image = UIImage(data: image)
    }
}
