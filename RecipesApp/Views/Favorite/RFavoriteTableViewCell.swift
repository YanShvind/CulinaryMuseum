
import UIKit

final class RFavoriteTableViewCell: UITableViewCell {

    static let identifier = "RFavoriteTableViewCell"
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "sklnvnv  nlkwenflwlfn  nwlfnwn wn lwfkn"
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cooking time: 45 minutes."
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Note: your note"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.backgroundColor = .secondarySystemBackground
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        addSubviews(customImageView, nameLabel, timeLabel, noteLabel)
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            customImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            customImageView.widthAnchor.constraint(equalToConstant: 170),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 55),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            timeLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            noteLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 3),
            noteLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            noteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            noteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
