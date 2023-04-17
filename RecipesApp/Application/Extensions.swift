
import UIKit

// добавление сразу нескольких элементов
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

// скрываем клавиатуру по нажатию
extension UIView {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

// обработчик ошибок
enum ImageError: Error {
    case invalidImageData
    case filterApplicationFailed
    case createCGImageFromCIContextFailed
}

// меняем рахмер изображения
extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        guard self.size != newSize else { return self }
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
