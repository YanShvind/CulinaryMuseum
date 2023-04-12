
import Foundation
import UIKit

protocol RAddNewRecipeViewDelegate: AnyObject {
    func didTappedImageButton()
}

final class RAddNewRecipeView: UIView {
    
    public weak var delegate: RAddNewRecipeViewDelegate?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        addConstraints()
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc
    private func didTapImage() {
        delegate?.didTappedImageButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RAddNewRecipeView {
    private func addConstraints() {
        addSubviews(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
        ])
    }
}
