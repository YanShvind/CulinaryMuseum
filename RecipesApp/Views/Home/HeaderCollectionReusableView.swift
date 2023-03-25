
import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel ()
        label.text = "header"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        backgroundColor = .systemBackground
        addSubview (headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint (equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 10)
        ])
    }
}
