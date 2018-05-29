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


var weeklyNotes: [NSManagedObject] = []

enum DataWorkCommand {
    case save
    case load
    // case delete
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

func coreDataManipulation(noteToSave: String?, timeStamp: Date?, command: DataWorkCommand) {
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    switch command {
    case .save:
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(noteToSave, forKeyPath: "name")
        note.setValue(timeStamp, forKey: "date")
        
        do {
            try managedContext.save()
            weeklyNotes.append(note)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        NotificationCenter.default.post(name: .reload, object: nil)
        
    case .load:
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        do {
            weeklyNotes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
}

func deleteEntry(indexPath: Int) {
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





