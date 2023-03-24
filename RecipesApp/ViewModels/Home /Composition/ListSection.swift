
import Foundation

enum ListSection {
    case popularity([ListItem])
    case vegetarian([ListItem])
    case shortCookingTime([ListItem])
    case healthy([ListItem])
    case lowCalorie([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .popularity(let items),
                .vegetarian(let items),
                .shortCookingTime(let items),
                .healthy(let items),
                .lowCalorie(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .popularity(_):
            return "Populatity"
        case .vegetarian(_):
            return "Vegetarian"
        case .shortCookingTime(_):
            return "Short Cooking Time"
        case .healthy(_):
            return "Healthy"
        case .lowCalorie(_):
            return "Low Calorie"
        }
    }
}
