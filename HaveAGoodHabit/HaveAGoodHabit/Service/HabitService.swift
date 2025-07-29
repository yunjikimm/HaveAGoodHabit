//
//  HabitService.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 5/4/25.
//

import Foundation
import CoreData

final class HabitService: HabitServiceProtocol {
    private let provider: CoreDataProviderProtocol

    init(provider: CoreDataProviderProtocol = CoreDataProvider()) {
        self.provider = provider
    }
    
    private let pageSize = 10
    private var currentPage = 0
    
    func fetchAll() async throws -> [Habit] {
        currentPage = 0
        
        return try await provider.fetchAll(limit: pageSize, offset: currentPage)
    }
    
    func fetchNextPage() async throws -> [Habit] {
        currentPage += 1
        
        let offset = pageSize * currentPage
        let nextPage = try await provider.fetchAll(limit: pageSize, offset: offset)
        
        return nextPage
    }
    
    func fetchHabit(id: UUID) async throws -> Habit? {
        try await provider.fetchHabit(id: id)
    }
    
    func save(habit: Habit) async throws {
        try await provider.save(habit: habit)
    }
    
    func update(habit: Habit) async throws {
        try await provider.update(habit: habit)
    }
    
    func delete(habit: Habit) async throws {
        try await provider.delete(habit: habit)
    }
}
