
import Foundation

final class RImageManager {
    
    static let shared = RImageManager()
    
    // Добавляем кеш, для того, чтобы
    // Данные не загружались снова
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(_ url: URL, complection: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            complection(.success(data as Data)) // NSData == Data (objc - swift)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            complection(.success(data))
        }
        task.resume()
    }
}

