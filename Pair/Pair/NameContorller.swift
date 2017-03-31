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
    
    var sections: Int {
        if names.count % 2 == 0 {
            return names.count / 2
        } else {
            return names.count / 2 + 1
        }
        
    }
    
    //MARK: - crud
    
    func create(name: String) -> Name {
        
        let name = Name(name: name)
        save()
        return name
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
