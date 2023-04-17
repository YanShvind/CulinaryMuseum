
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
    
    lazy var recipeNameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Enter description..."
        textView.textColor = .systemGray2
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.0).cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var recipeDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Enter description..."
        textView.textColor = .systemGray2
        textView.backgroundColor = .systemGray5
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.0).cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.addGestureRecognizer(gesture)
        addConstraints()
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
        addSubviews(imageView, recipeNameTextView, recipeDescriptionTextView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 17),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            recipeNameTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            recipeNameTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            recipeNameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            recipeNameTextView.heightAnchor.constraint(equalToConstant: 38),
            
            recipeDescriptionTextView.topAnchor.constraint(equalTo: recipeNameTextView.bottomAnchor, constant: 12),
            recipeDescriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            recipeDescriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            recipeDescriptionTextView.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
}
