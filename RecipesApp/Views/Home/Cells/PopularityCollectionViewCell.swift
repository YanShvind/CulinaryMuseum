
import UIKit

final class PopularityCollectionViewCell: UICollectionViewCell {
    
    lazy var popularView = CustomVeiwCell()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // очищаем изображение в ячейке перед ее повторным использованием
    override func prepareForReuse() {
        super.prepareForReuse()
        popularView.imageView.image = nil
        popularView.nameLabel.text = nil
        popularView.readyInTimeLabel.text = nil
        popularView.heartImageView.tintColor = .label
    }
    
    func configure(viewModel: RSearchCollectionViewCellViewModel) {
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
}
