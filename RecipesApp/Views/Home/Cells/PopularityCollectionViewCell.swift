
import UIKit

final class PopularityCollectionViewCell: UICollectionViewCell {
    
    lazy var popularView = CustomViewCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    // очищаем изображение в ячейке перед ее повторным использованием
    override func prepareForReuse() {
        super.prepareForReuse()
        popularView.imageView.image = nil
        popularView.nameLabel.text = nil
        popularView.readyInTimeLabel.text = nil
        popularView.heartImageView.tintColor = .label
    }
    
    public func configure(viewModel: RCollectionViewCellViewModel) {
       popularView.nameLabel.text = viewModel.recipeName
       popularView.readyInTimeLabel.text = "\(viewModel.recipeTime) min."
       popularView.imageView.image = nil

        viewModel.fetchImage { [weak self] result in
           switch result {
           case .success(let data):
               DispatchQueue.main.async { [weak self] in
                   guard let strongSelf = self else { return }
                   strongSelf.popularView.imageView.image = UIImage(data: data)
                   strongSelf.popularView.spinnerAnimating(animate: false)
               }
           case .failure(let error):
               print(String(describing: error))
               break
           }
       }

       if viewModel.isFavorite {
           popularView.heartImageView.tintColor = .systemRed
       } else {
           popularView.heartImageView.tintColor = .label
       }
    }

    private func setUpView() {
        addSubview(popularView)
        NSLayoutConstraint.activate([
            popularView.topAnchor.constraint(equalTo: topAnchor),
            popularView.leadingAnchor.constraint(equalTo: leadingAnchor),
            popularView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
