//
//  HabitListViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import Foundation

final class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private var currentPage = 0
    private let pageSize = 10
    
    private let provider = CoreDataProvider()
    
    func fetchHabits() {
        currentPage = 0
        
        habits = provider.fetchHabits(limit: pageSize, offset: currentPage)
    }
    
    func fetchNextPage() {
        currentPage += 1
        
        let offset = currentPage * pageSize
        let nextPage = provider.fetchHabits(limit: pageSize, offset: offset)
        
        habits.append(contentsOf: nextPage)
    }
    
    func addHabit(habit: Habit) {
        provider.save(habit: habit)
        fetchHabits()
    }
    
    func updateHabit(habit: Habit) {
        provider.update(habit: habit)
        fetchHabits()
    }
    
    func deleteHabit(habit: Habit) {
        provider.delete(habit: habit)
        fetchHabits()
    }
}
