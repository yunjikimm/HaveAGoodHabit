//
//  HabitListViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import Foundation

final class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let service: HabitServiceProtocol

    init(service: HabitServiceProtocol = HabitService()) {
        self.service = service
    }
    
    func fetchAll() {
        habits = service.fetchAll()
    }
    
    func fetchNextPage() {
        let nextPage = service.fetchAll()
        
        habits.append(contentsOf: nextPage)
    }
    
    func fetchHabit(id: UUID) {
        guard let newHabit = service.fetchHabit(id: id) else { return }
        
        guard let index = habits.firstIndex(where: { $0.id == id }) else { return }
        
        habits[index] = newHabit
        habits = habits.map { $0.id == newHabit.id ? newHabit : $0 }
    }
    
    func save(habit: Habit) {
        service.save(habit: habit)
        fetchAll()
    }
    
    func update(habit: Habit) {
        service.update(habit: habit)
        fetchHabit(id: habit.id)
    }
    
    func delete(habit: Habit) {
        service.delete(habit: habit)
        fetchAll()
    }
}
