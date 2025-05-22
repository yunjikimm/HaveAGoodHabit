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
    
    func fetchAll() -> [Habit] {
        currentPage = 0
        
        return provider.fetchAll(limit: pageSize, offset: currentPage)
    }
    
    func fetchNextPage() -> [Habit] {
        currentPage += 1
        
        let offset = pageSize * currentPage
        let nextPage = provider.fetchAll(limit: pageSize, offset: offset)
        
        return nextPage
    }
    
    func fetchHabit(id: UUID) -> Habit? {
        provider.fetchHabit(id: id)
    }
    
    func save(habit: Habit) {
        provider.save(habit: habit)
    }
    
    func update(habit: Habit) {
        provider.update(habit: habit)
    }
    
    func delete(habit: Habit) {
        provider.delete(habit: habit)
    }
}
