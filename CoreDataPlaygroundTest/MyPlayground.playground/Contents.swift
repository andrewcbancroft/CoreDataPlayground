import UIKit
import CoreData

// Core Data Stack Setup for In-Memory Store
public func createMainContext() -> NSManagedObjectContext {
	
	// Replace "Model" with the name of your model
	let modelUrl = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
	guard let model = NSManagedObjectModel.init(contentsOfURL: modelUrl!) else { fatalError("model not found") }
	
	let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
	try! psc.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
	
	let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
	context.persistentStoreCoordinator = psc
	
	return context
}

let context = createMainContext()

// Insert a new Entity
let ent = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context)
ent.setValue(42, forKey: "attribute")

try! context.save()

// Perform a fetch request
let fr = NSFetchRequest(entityName: "Entity")
let result = try! context.executeFetchRequest(fr)

print(result)