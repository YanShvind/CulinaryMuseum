
import UIKit

final class RTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemRed
        setUpTabs()
    }

    private func setUpTabs() {
        let homeVC = RHomeViewController()
        let categoriesVC = RCategoriesViewController()
        let favoritesVC = RFavoritesViewController()
        let newRecipeVC = RNewRecipeViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        categoriesVC.navigationItem.largeTitleDisplayMode = .automatic
        favoritesVC.navigationItem.largeTitleDisplayMode = .automatic
        newRecipeVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: categoriesVC)
        let nav3 = UINavigationController(rootViewController: favoritesVC)
        let nav4 = UINavigationController(rootViewController: newRecipeVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.fill"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Categories",
                                       image: UIImage(systemName: "bookmark.fill"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Favorites",
                                       image: UIImage(systemName: "heart.fill"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "New Recipe",
                                       image: UIImage(systemName: "plus"),
                                       tag: 4)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}

