
import Foundation

enum ListSection {
    case popularity([ListItem])
    case vegetarian([ListItem])
    case nutFree([ListItem])
    case glutenFree([ListItem])
    case lowCalorie([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .popularity(let items),
                .vegetarian(let items),
                .nutFree(let items),
                .glutenFree(let items),
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
        case .nutFree(_):
            return "Nut Free"
        case .glutenFree(_):
            return "Gluten Free"
        case .lowCalorie(_):
            return "Low Calorie"
        }
    }
}
