//
//  HabitListViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import Foundation

@MainActor
final class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let service: HabitServiceProtocol

    init(service: HabitServiceProtocol = HabitService()) {
        self.service = service
    }
    
    func fetchAll() async throws {
        habits = try await service.fetchAll()
    }
    
    func fetchNextPage() async throws {
        let nextPage = try await service.fetchNextPage()
        
        habits.append(contentsOf: nextPage)
    }
    
    func fetchHabit(id: UUID) async throws {
        guard let newHabit = try await service.fetchHabit(id: id) else { return }
        
        guard let index = habits.firstIndex(where: { $0.id == id }) else { return }
        
        habits[index] = newHabit
        habits = habits.map { $0.id == newHabit.id ? newHabit : $0 }
    }
    
    func save(habit: Habit) async throws {
        try await service.save(habit: habit)
    }
    
    func update(habit: Habit) async throws {
        try await service.update(habit: habit)
        
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index] = habit
    }
    
    func delete(habit: Habit) async throws {
        try await service.delete(habit: habit)
    }
}
