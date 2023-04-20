
import UIKit

final class RDescriptionPopup: UIView {
    
    public var index: Int = 0
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Description"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineImageView: UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "lineImage")
        lineImage.contentMode = .scaleToFill
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        return lineImage
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.text = ""
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        configureViewComponents()
        animateIn()
    }
    
    private func setUpView() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
    }
    
    @objc
    public func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) {(complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc
    private func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        }) {(complete) in
            let description = RNewRecipeDataModel.shared.getAllRecipes()[self.index].descriptionn
            self.descriptionTextView.text = description
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RDescriptionPopup {
    private func configureViewComponents() {
        addSubview(container)
        container.addSubviews(topLabel, lineImageView, descriptionTextView)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33),
            
            topLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            topLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -10),
            topLabel.bottomAnchor.constraint(equalTo: lineImageView.topAnchor, constant: -20),
            
            lineImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            lineImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            lineImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: 0),
            lineImageView.heightAnchor.constraint(equalToConstant: 2),
            
            descriptionTextView.topAnchor.constraint(equalTo: lineImageView.bottomAnchor, constant: 3),
            descriptionTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 3),
            descriptionTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -3),
            descriptionTextView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -3)
        ])
    }
}
