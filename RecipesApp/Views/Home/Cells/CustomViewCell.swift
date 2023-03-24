
import UIKit

final class CustomViewCell: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewBackgroundHeart: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var viewBackgroundTime: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var readyInTimeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartTap))
        viewBackgroundHeart.addGestureRecognizer(tapGesture)
        
        addSubviews(imageView, nameLabel, viewBackgroundHeart, viewBackgroundTime, spinner)
        viewBackgroundHeart.addSubview(heartImageView)
        viewBackgroundTime.addSubview(readyInTimeLabel)
        addConstraints()
        setUpLayer()
    }
    
    @objc
    private func heartTap(_ sender: UITapGestureRecognizer) {
        print("DDD")
    }
    
    public func spinnerAnimating(animate: Bool) {
        if animate {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomViewCell {
    // MARK: AddConstraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
            viewBackgroundHeart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            viewBackgroundHeart.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            viewBackgroundHeart.widthAnchor.constraint(equalToConstant: 30),
            viewBackgroundHeart.heightAnchor.constraint(equalToConstant: 35),
            
            heartImageView.topAnchor.constraint(equalTo: viewBackgroundHeart.topAnchor, constant: 3),
            heartImageView.leadingAnchor.constraint(equalTo: viewBackgroundHeart.leadingAnchor, constant: 2),
            heartImageView.trailingAnchor.constraint(equalTo: viewBackgroundHeart.trailingAnchor, constant: -2),
            heartImageView.bottomAnchor.constraint(equalTo: viewBackgroundHeart.bottomAnchor, constant: -3),
            
            viewBackgroundTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            viewBackgroundTime.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            viewBackgroundTime.widthAnchor.constraint(equalToConstant: 75),
            viewBackgroundTime.heightAnchor.constraint(equalToConstant: 27),
            
            readyInTimeLabel.topAnchor.constraint(equalTo: viewBackgroundTime.topAnchor, constant: 3),
            readyInTimeLabel.leadingAnchor.constraint(equalTo: viewBackgroundTime.leadingAnchor, constant: 2),
            readyInTimeLabel.trailingAnchor.constraint(equalTo: viewBackgroundTime.trailingAnchor, constant: -2),
            readyInTimeLabel.bottomAnchor.constraint(equalTo: viewBackgroundTime.bottomAnchor, constant: -3),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: AddShadows
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.label.cgColor
        layer.cornerRadius = 4
        layer.shadowOffset = CGSize(width: -4, height: 4)
        layer.shadowOpacity = 0.3
    }
}

