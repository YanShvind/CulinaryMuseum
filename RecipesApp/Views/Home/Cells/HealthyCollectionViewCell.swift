
import UIKit

final class HealthyCollectionViewCell: UICollectionViewCell {
    
    lazy var healthyView = CustomViewCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        healthyView.imageView.image = nil
        healthyView.nameLabel.text = nil
        healthyView.readyInTimeLabel.text = nil
        healthyView.heartImageView.tintColor = .label
    }
    
    public func configure(viewModel: RCollectionViewCellViewModel) {
        healthyView.nameLabel.text = viewModel.recipeName
        healthyView.readyInTimeLabel.text = "\(viewModel.recipeTime) min."
        healthyView.imageView.image = nil
        
        viewModel.fetchImage { [weak self] result in
           switch result {
           case .success(let data):
               DispatchQueue.main.async { [weak self] in
                   guard let strongSelf = self else { return }
                   strongSelf.healthyView.imageView.image = UIImage(data: data)
                   strongSelf.healthyView.spinnerAnimating(animate: false)
               }
           case .failure(let error):
               print(String(describing: error))
               break
           }
       }
        
        if viewModel.isFavorite {
            healthyView.heartImageView.tintColor = .systemRed
        } else {
            healthyView.heartImageView.tintColor = .label
        }
    }
    
    private func setUpView() {
        addSubview(healthyView)
        NSLayoutConstraint.activate([
            healthyView.topAnchor.constraint(equalTo: topAnchor),
            healthyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            healthyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            healthyView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
