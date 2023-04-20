
import UIKit

protocol RPopupViewDelegate: AnyObject {
    func didtakePhotoButtonTapped()
    func didChooseImageButtonTapped()
    func didDeleteButtonTapped()
}

final class RPopupView: UIView {
    
    public weak var delegate: RPopupViewDelegate?
    
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
        label.text = "Insert your photo"
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
    
    private let takePhotoButton: RButtonExtension = {
        let button = RButtonExtension()
        button.setTitle("Take a photo", for: .normal)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let chooseImageButton: RButtonExtension = {
        let button = RButtonExtension()
        button.setTitle("Your gallery", for: .normal)
        button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let deleteButton: RButtonExtension = {
        let button = RButtonExtension()
        button.setTitle("Delete photo", for: .normal)
        button.setImage(UIImage(systemName: "delete.left"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .systemRed
        return button
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
        
        takePhotoButton.addTarget(self,
                                  action: #selector(takePhotoButtonTapped),
                                  for: .touchUpInside)
        chooseImageButton.addTarget(self,
                                    action: #selector(chooseImageButtonTapped),
                                    for: .touchUpInside)
        deleteButton.addTarget(self,
                               action: #selector(deleteButtonTapped),
                               for: .touchUpInside)
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
            
        }
    }
        
    @objc
    private func takePhotoButtonTapped() {
        delegate?.didtakePhotoButtonTapped()
    }
    
    @objc
    private func chooseImageButtonTapped() {
        delegate?.didChooseImageButtonTapped()
    }
    
    @objc
    private func deleteButtonTapped() {
        delegate?.didDeleteButtonTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RPopupView {
    private func configureViewComponents() {
        addSubview(container)
        container.addSubviews(topLabel, lineImageView, takePhotoButton, chooseImageButton, deleteButton)
        
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.37),
            
            topLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            topLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -10),
            topLabel.bottomAnchor.constraint(equalTo: lineImageView.topAnchor, constant: -20),
            
            lineImageView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            lineImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            lineImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: 0),
            lineImageView.heightAnchor.constraint(equalToConstant: 2),
            
            takePhotoButton.topAnchor.constraint(equalTo: lineImageView.bottomAnchor, constant: 7),
            takePhotoButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            takePhotoButton.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -15),
            takePhotoButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2),
            
            chooseImageButton.topAnchor.constraint(equalTo: takePhotoButton.bottomAnchor, constant: 7),
            chooseImageButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            chooseImageButton.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -15),
            chooseImageButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2),
            
            deleteButton.topAnchor.constraint(equalTo: chooseImageButton.bottomAnchor, constant: 7),
            deleteButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -15),
            deleteButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2)
        ])
    }
}
