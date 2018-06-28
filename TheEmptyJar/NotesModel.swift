//
//  NotesModel.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 1/11/17.
//  Copyright © 2017 Jesse Anderson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//struct Note {
//    var date = Date()
//    var text = String()
//}
//
//var notesCollection = Array<Note>()
//
//var weeklyNotes = [Date: String]()


//[REVIEW] - Global vars and functions should be avoided

//[REVIEW] - Working with NSManagedObject is a little tricky. Instead always try to work with the type you define directly, in this case `Note`
var weeklyNotes: [NSManagedObject] = []

enum DataWorkCommand {
    case save
    case load
    // case delete
}

//[REVIEW] - Nice!
extension Notification.Name {
    static let reload = Notification.Name("reload")
}

//[REVIEW] - The function name isn't really meaningful. Better would be something like `writeToModel` or anything that describes what's going on.
func coreDataManipulation(noteToSave: String?, timeStamp: Date?, command: DataWorkCommand) {
    
    //[REVIEW] - The managedContext should be a var of the Core Data model. So when you move the Core Data code out of the AppDelegate, create a computed property:
    
    /*
     var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
     }
     */
    
    // Then use the property like this
    
    /*
     CoreDataStack.shared.managedContext
     */
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    switch command {
    case .save:
        
        //[REVIEW] - Instead of this
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // write this
        // let note = Note(entity: Note.entity(), insertInto: CoreDataStack.shared.managedContext)
        
        // Strings should be avoided whenever possible. Either create a struct with static constants, or in this case assign the values directly.
        // note.name = noteToSave
        // note.date = timeStamp
        
        note.setValue(noteToSave, forKeyPath: "name")
        note.setValue(timeStamp, forKey: "date")
        
        do {
            try managedContext.save()
            weeklyNotes.append(note)
            
            //[REVIEW] - No need to cast to NSError here. Delete the `let error as NSError` and print error.localizedDescription. This will also help when localizing for other languages
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        NotificationCenter.default.post(name: .reload, object: nil)
        
    case .load:
        //[REVIEW] - This should be done with an NSFetchedResultsController in the table view. With that you won't need to manually keep track of the array of notes, but can delegate the table view to do the heavy lifting.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        do {
            weeklyNotes = try managedContext.fetch(fetchRequest)
            
            //[REVIEW] - Same as above
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
}

func deleteEntry(indexPath: Int) {
    //[REVIEW] - Same as above
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
    
    do {
    let fetchResults = try managedContext.fetch(fetchRequest)
        
        managedContext.delete(fetchResults[indexPath])
        try managedContext.save()
        
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }

}





