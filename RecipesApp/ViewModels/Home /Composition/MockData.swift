
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
    
    private var nutFree: ListSection {
        .nutFree([.init(title: "", image: ""),
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
    
    private var glutenFree: ListSection {
        .glutenFree([.init(title: "", image: ""),
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
        [popularity, vegetarian, nutFree, glutenFree, lowCalorie]
    }
}
