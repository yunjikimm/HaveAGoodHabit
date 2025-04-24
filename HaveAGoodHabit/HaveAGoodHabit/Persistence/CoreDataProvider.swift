//
//  CoreDataProvider.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/11/25.
//

import CoreData

// Core Data CRUD
final class CoreDataProvider {
    private let context = PersistenceController.shared.viewContext
    
    func fetchHabits(limit: Int, offset: Int) -> [Habit] {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        guard let habits = try? context.fetch(request) else {
            return []
        }
        
        return habits.map { $0.toDomain() }
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
