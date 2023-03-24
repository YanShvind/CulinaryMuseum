
import UIKit

final class LowCalorieCollectionViewCell: UICollectionViewCell {
    
    lazy var lowCalorieView = CustomViewCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lowCalorieView.imageView.image = nil
        lowCalorieView.nameLabel.text = nil
        lowCalorieView.readyInTimeLabel.text = nil
        lowCalorieView.heartImageView.tintColor = .label
    }
    
    public func configure(viewModel: RCollectionViewCellViewModel) {
        lowCalorieView.nameLabel.text = viewModel.recipeName
        lowCalorieView.readyInTimeLabel.text = "\(viewModel.recipeTime) min."
        lowCalorieView.imageView.image = nil
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.lowCalorieView.imageView.image = UIImage(data: data)
                    strongSelf.lowCalorieView.spinnerAnimating(animate: false)
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        
        if viewModel.isFavorite {
            lowCalorieView.heartImageView.tintColor = .systemRed
        } else {
            lowCalorieView.heartImageView.tintColor = .label
        }
    }
    
    private func setUpView() {
        addSubview(lowCalorieView)
        NSLayoutConstraint.activate([
            lowCalorieView.topAnchor.constraint(equalTo: topAnchor),
            lowCalorieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lowCalorieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lowCalorieView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
