
import UIKit

final class RHomeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewBackgroundHeart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewBackgroundTime: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let readyInTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "155 min."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubviews(imageView, nameLabel, viewBackgroundTime)
        imageView.addSubview(viewBackgroundHeart)
        viewBackgroundHeart.addSubview(heartImageView)
        viewBackgroundTime.addSubview(readyInTimeLabel)
        addConstrants()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // настройка теней
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstrants() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
            viewBackgroundHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            viewBackgroundHeart.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            viewBackgroundHeart.widthAnchor.constraint(equalToConstant: 30),
            viewBackgroundHeart.heightAnchor.constraint(equalToConstant: 35),
            
            heartImageView.topAnchor.constraint(equalTo: viewBackgroundHeart.topAnchor, constant: 3),
            heartImageView.leadingAnchor.constraint(equalTo: viewBackgroundHeart.leadingAnchor, constant: 2),
            heartImageView.trailingAnchor.constraint(equalTo: viewBackgroundHeart.trailingAnchor, constant: -2),
            heartImageView.bottomAnchor.constraint(equalTo: viewBackgroundHeart.bottomAnchor, constant: -3),
            
            viewBackgroundTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            viewBackgroundTime.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            viewBackgroundTime.widthAnchor.constraint(equalToConstant: 70),
            viewBackgroundTime.heightAnchor.constraint(equalToConstant: 27),
            
            readyInTimeLabel.topAnchor.constraint(equalTo: viewBackgroundTime.topAnchor, constant: 3),
            readyInTimeLabel.leadingAnchor.constraint(equalTo: viewBackgroundTime.leadingAnchor, constant: 2),
            readyInTimeLabel.trailingAnchor.constraint(equalTo: viewBackgroundTime.trailingAnchor, constant: -2),
            readyInTimeLabel.bottomAnchor.constraint(equalTo: viewBackgroundTime.bottomAnchor, constant: -3),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    public func configure(with viewModel: RRecipeCollectionViewCellViewModel) {
        nameLabel.text = viewModel.recipeName
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
