//
//  PersistenceController.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/10/25.
//

import Foundation
import CoreData

// Core Data Stack 설정
class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: CoreDataModelName.habitDataModel.rawValue)
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("could not load persistent stores: \(error)")
            } else {
                print("successfully loaded persistent stores")
            }
        }
    }
    
    
}
