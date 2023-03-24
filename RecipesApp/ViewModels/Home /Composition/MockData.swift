
import Foundation

struct MockData {
    
    static let shared = MockData()
    
    private var popularity: ListSection {
        .popularity([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var vegetarian: ListSection {
        .vegetarian([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var shortCookingTime: ListSection {
        .shortCookingTime([.init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: ""),
                  .init(title: "", image: "")
        ])
    }
    
    private var healthy: ListSection {
        .healthy([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    private var lowCalorie: ListSection {
        .lowCalorie([.init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: ""),
                     .init(title: "", image: "")
        ])
    }
    
    var sections: [ListSection] {
        [popularity, vegetarian, shortCookingTime, healthy, lowCalorie]
    }
}
