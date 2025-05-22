//
//  CoreDataProvider.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/11/25.
//

import CoreData

// Core Data CRUD
final class CoreDataProvider: CoreDataProviderProtocol {
    private let context = PersistenceController.shared.viewContext
    
    func fetchAll(limit: Int, offset: Int) -> [Habit] {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        guard let habits = try? context.fetch(request) else {
            return []
        }
        
        return habits.map { $0.toDomain() }
    }
    
    func fetchHabit(id: UUID) -> Habit {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        do {
            guard let result = try context.fetch(request).first else {
                fatalError("Failed to fetch habit")
            }
            return result.toDomain()
        } catch {
            fatalError("Failed to fetch habit: \(error)")
        }
    }
    
    func save(habit: Habit) {
        do {
            let entity = HabitEntity(context: context)
            entity.update(with: habit)
        
            try context.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }
    
    func update(habit: Habit) {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
        
        do {
            guard let entity = try context.fetch(request).first else {
                return
            }
            
            entity.update(with: habit)
            
            try context.save()
        } catch {
            fatalError("Failed to update context: \(error)")
        }
    }
    
    func delete(habit: Habit) {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
        
        do {
            guard let entity = try context.fetch(request).first else {
                return
            }
            
            context.delete(entity)
            
            try context.save()
        } catch {
            fatalError("Failed to delete context: \(error)")
        }
    }
}
