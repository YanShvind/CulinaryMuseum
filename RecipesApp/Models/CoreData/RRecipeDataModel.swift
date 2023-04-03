
import CoreData
import UIKit

final class RRecipeDataModel {
    
    private var viewModel = RFavoriteViewViewModel()
    
    static let shared = RRecipeDataModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveRecipe(id: Int, name: String, time: Int, image: UIImage) -> Recipes {
        let entity = NSEntityDescription.entity(forEntityName: "Recipes", in: context)!
        let recipe = NSManagedObject(entity: entity, insertInto: context) as! Recipes
        
        recipe.id = Int32(id)
        recipe.name = name
        recipe.time = Int32(time)
        recipe.image = image.pngData()
        
        do {
            try context.save()
            viewModel.recipes.append(recipe)
            return recipe
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            fatalError("Failed to save recipe")
        }
    }
    
    func deleteRecipe(withId recipeId: NSManagedObjectID) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let recipeToDelete = context.object(with: recipeId)
        context.delete(recipeToDelete)
        
        do {
            try context.save()
        } catch {
            print("Error deleting recipe: \(error.localizedDescription)")
        }
    }
    
    func getAllRecipes() -> [Recipes] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipes")
        
        do {
            let result = try context.fetch(request)
            return result as! [Recipes]
        } catch {
            print("Error getting recipes: \(error.localizedDescription)")
            return []
        }
    }
}
