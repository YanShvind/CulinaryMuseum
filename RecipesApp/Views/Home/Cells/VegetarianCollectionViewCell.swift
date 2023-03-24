
import UIKit

final class VegetarianCollectionViewCell: UICollectionViewCell {
    
    lazy var vegetarianView = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
        
    public func configure(viewModel: RSearchCollectionViewCellViewModel) {
        vegetarianView.nameLabel.text = viewModel.recipeName
        vegetarianView.readyInTimeLabel.text = "\(viewModel.recipeTime) min."
        vegetarianView.imageView.image = nil
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.vegetarianView.imageView.image = image
                    self?.vegetarianView.spinnerAnimating(animate: false)
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        if viewModel.isFavorite {
            vegetarianView.heartImageView.tintColor = .systemRed
        } else {
            vegetarianView.heartImageView.tintColor = .label
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        vegetarianView.imageView.image = nil
        vegetarianView.nameLabel.text = nil
        vegetarianView.readyInTimeLabel.text = nil
        vegetarianView.heartImageView.tintColor = .label
    }
    
    private func setUpView() {
        addSubview(vegetarianView)
        NSLayoutConstraint.activate([
            vegetarianView.topAnchor.constraint(equalTo: topAnchor),
            vegetarianView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vegetarianView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vegetarianView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
