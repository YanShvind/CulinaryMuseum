
import UIKit

final class ShortCookingTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var shortCookingTimeView = CustomViewCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shortCookingTimeView.imageView.image = nil
        shortCookingTimeView.nameLabel.text = nil
        shortCookingTimeView.readyInTimeLabel.text = nil
        shortCookingTimeView.heartImageView.tintColor = .label
    }
        
    public func configure(viewModel: RCollectionViewCellViewModel) {
        shortCookingTimeView.nameLabel.text = viewModel.recipeName
        shortCookingTimeView.readyInTimeLabel.text = "\(viewModel.recipeTime) min."
        shortCookingTimeView.imageView.image = nil

        viewModel.fetchImage { [weak self] result in
           switch result {
           case .success(let data):
               DispatchQueue.main.async { [weak self] in
                   guard let strongSelf = self else { return }
                   strongSelf.shortCookingTimeView.imageView.image = UIImage(data: data)
                   strongSelf.shortCookingTimeView.spinnerAnimating(animate: false)
               }
           case .failure(let error):
               print(String(describing: error))
               break
           }
       }

       if viewModel.isFavorite {
           shortCookingTimeView.heartImageView.tintColor = .systemRed
       } else {
           shortCookingTimeView.heartImageView.tintColor = .label
       }
    }
    
    private func setUpView() {
        addSubview(shortCookingTimeView)
        NSLayoutConstraint.activate([
            shortCookingTimeView.topAnchor.constraint(equalTo: topAnchor),
            shortCookingTimeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shortCookingTimeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shortCookingTimeView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
