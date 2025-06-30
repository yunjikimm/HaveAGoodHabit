//
//  CoreDataProvider.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/11/25.
//

import CoreData

// Core Data CRUD
final class CoreDataProvider: CoreDataProviderProtocol {
    private let context = PersistenceController.shared
    
    func fetchAll(limit: Int, offset: Int) async throws -> [Habit] {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        return try await context.viewContext.perform {
            let habits = try request.execute()
            return habits.map { $0.toDomain() }
            
        }
    }
    
    func fetchHabit(id: UUID) async throws -> Habit {
        let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
        
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        return try await context.viewContext.perform {
            guard let habit = try request.execute().first else {
                fatalError("Habit not found")
            }
            return habit.toDomain()
        }
    }
    
    func save(habit: Habit) async throws {
        try await context.container.performBackgroundTask { context in
            let entity = HabitEntity(context: context)
            
            entity.update(with: habit)
            
            try context.save()
        }
    }
    
    func update(habit: Habit) async throws {
        try await context.container.performBackgroundTask { context in
            let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
            request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
            
            guard let entity = try request.execute().first else {
                return
            }
            
            entity.update(with: habit)
            
            try context.save()
        }
    }
    
    func delete(habit: Habit) async throws {
        try await context.container.performBackgroundTask { context in
            let request: NSFetchRequest<HabitEntity> = NSFetchRequest(entityName: CoreDataEntityName.habit.rawValue)
            request.predicate = NSPredicate(format: "id == %@", habit.id as CVarArg)
            
            guard let entity = try request.execute().first else {
                return
            }
            
            context.delete(entity)
            
            try context.save()
        }
    }
}
