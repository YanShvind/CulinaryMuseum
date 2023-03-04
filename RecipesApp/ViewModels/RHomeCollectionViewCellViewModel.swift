
import Foundation

final class RHomeCollectionViewCellViewModel: Hashable, Equatable {
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
        RImageManager.shared.downloadImage(imageUrl, complection: complection)
    }
    
    // MARK: - Hashable
    static func == (lhs: RHomeCollectionViewCellViewModel, rhs: RHomeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recipeName)
        hasher.combine(recipeTime)
        hasher.combine(isFavorite)
        hasher.combine(recipeImageUrl)
    }
}
