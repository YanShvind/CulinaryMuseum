
import Foundation
import UIKit

final class RCollectionViewCellViewModel: Hashable, Equatable {
    
    public let recipeName: String
    public let recipeTime: Int
    public var isFavorite: Bool
    private let recipeImageUrl: URL?
    
    init(recipeName: String, recipeTime: Int, recipeImageUrl: URL?, isFavorite: Bool) {
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.isFavorite = isFavorite
        self.recipeImageUrl = recipeImageUrl
    }
    
    public func fetchImage(complection: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = recipeImageUrl else {
            print("Invalid image URL")
            return
        }
        RImageManager.shared.downloadImage(imageUrl) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    complection(.failure(ImageError.invalidImageData))
                    return
                }
                
                let filter = CIFilter(name: "CIColorControls")
                filter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
                filter?.setValue(1.0, forKey: kCIInputContrastKey)
                filter?.setValue(1.0, forKey: kCIInputSaturationKey)
                
                guard let outputImage = filter?.outputImage else {
                    complection(.failure(ImageError.filterApplicationFailed))
                    return
                }
                
                let context = CIContext()
                guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
                    complection(.failure(ImageError.createCGImageFromCIContextFailed))
                    return
                }
                
                let filteredImageData = UIImage(cgImage: cgImage).pngData()
                complection(.success(filteredImageData ?? imageData))
                
            case .failure(let error):
                complection(.failure(error))
            }
        }    }
    
    // MARK: - Hashable
    static func == (lhs: RCollectionViewCellViewModel, rhs: RCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recipeName)
        hasher.combine(recipeTime)
        hasher.combine(isFavorite)
        hasher.combine(recipeImageUrl)
    }
}
