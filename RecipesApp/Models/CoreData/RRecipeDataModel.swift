
import CoreData
import UIKit

final class RRecipeDataModel {
    
    static let shared = RRecipeDataModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveRecipe(url: String, id: Int, name: String, time: Int, image: UIImage) -> Recipes {
        let entity = NSEntityDescription.entity(forEntityName: "Recipes", in: context)!
        let recipe = NSManagedObject(entity: entity, insertInto: context) as! Recipes
        
        recipe.url = url
        recipe.id = Int32(id)
        recipe.name = name
        recipe.time = Int32(time)
        recipe.image = image.jpegData(compressionQuality: 0.8)
        
        do {
            try context.save()
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
