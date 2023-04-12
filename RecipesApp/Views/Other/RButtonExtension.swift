
import UIKit

class RButtonExtension : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton () {
        backgroundColor = .systemGray5
        setTitleColor(UIColor(named: "appColor"), for: .normal)
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .center
        imageView?.contentMode = .scaleAspectFit
    }
}

