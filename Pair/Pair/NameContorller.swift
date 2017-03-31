//
//  NameContorller.swift
//  Pair
//
//  Created by Taylor Phillips on 3/31/17.
//  Copyright © 2017 Taylor Phillips. All rights reserved.
//

import Foundation
import CoreData

class NameController {
    
    static let shared = NameController()
    let moc = CoreDataStack.context
//    
//    let fetchedResultsController: NSFetchedResultsController<Name>
//    
//    init() {
//        let request: NSFetchRequest<Name> = Name.fetchRequest()
//        let sortDescriptor = NSSortDescriptor()
//        request.sortDescriptors = [sortDescriptor]
//        
//        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
//        do {
//            try self.fetchedResultsController.performFetch()
//        } catch {
//            print("couldn't fetch Names from moc through FRC")
//        }
//    }
//    
    
    
    //MARK: - crud
    
    func create(name: String) {
        
        let _ = Name(name: name)
        save()

    }
    
    var names: [Name] {
        let request: NSFetchRequest<Name> = Name.fetchRequest()
        do {
            return try moc.fetch(request)
        } catch {
            return []
        }
    }
    
    func delete(name: Name) {
        
        moc.delete(name)
        save()
    }
    func save() {
        
        do {
            try moc.save()
        } catch {
            print("Didn't save to the managed object context")
        }
    }
}
