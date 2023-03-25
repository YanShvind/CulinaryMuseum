
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

extension StringProtocol {
    func changeImageSize(to size: ImageSizes) -> String {
        let imageName = self.dropLast(11)
        let finalString = imageName + size.rawValue + ".jpg"
        return finalString
    }
}

enum ImageSizes: String {
    case mini = "90x90"
    case verySmall = "240x150"
    case small = "312x150"
    case medium = "312x231"
    case big = "480x360"
    case bigger = "556x370"
    case huge = "636x393"
}

enum ImageError: Error {
    case invalidImageData
    case filterApplicationFailed
    case createCGImageFromCIContextFailed
}
