
import Foundation
import UIKit

final class RHomeViewViewModel: NSObject {
    struct ListItem {
        let title: String
        let image: String
    }
    
    enum ListSection {
        case populatity([ListItem])
        case vegetarian([ListItem])
        
        var items: [ListItem] {
            switch self {
            case .populatity(let items),
                    .vegetarian(let items):
                return items
            }
        }
        
        var count: Int {
            items.count
        }
        
        var title: String {
            switch self {
            case .populatity(_):
                return "Populatity"
            case .vegetarian(_):
                return "Vegetarian"
            }
        }
    }
    
    private var popularity: ListSection {
        .populatity([.init(title: "", image: ""),
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
    
    var sections: [ListSection] {
        [popularity, vegetarian]
    }
}

extension RHomeViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section]{
        case .populatity(let popular):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularityCollectionViewCell", for: indexPath) as? PopularityCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
            
        case .vegetarian(let vegan):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VegetarianCollectionViewCell", for: indexPath) as? VegetarianCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
