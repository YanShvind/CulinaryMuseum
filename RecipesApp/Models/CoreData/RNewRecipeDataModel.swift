
import CoreData
import UIKit

final class RNewRecipeDataModel {
    
    static let shared = RNewRecipeDataModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveRecipe(name: String, description: String, image: UIImage) -> NewRecipe {
        let entity = NSEntityDescription.entity(forEntityName: "NewRecipe", in: context)!
        let recipe = NSManagedObject(entity: entity, insertInto: context) as! NewRecipe
        
        recipe.name = name
        recipe.descriptionn = description
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
    
    func getAllRecipes() -> [NewRecipe] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewRecipe")
        
        do {
            let result = try context.fetch(request)
            return result as! [NewRecipe]
        } catch {
            print("Error getting recipes: \(error.localizedDescription)")
            return []
        }
    }
}
