//
//  HabitListViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import Foundation

final class HabitListViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let provider = CoreDataProvider()
    
    func fetchHabits() {
        habits = provider.fetchAll()
    }
    
    func addHabit(habit: Habit) {
        provider.save(habit: habit)
        fetchHabits()
    }
    
    func updateHabit(habit: Habit) {
        provider.save(habit: habit)
        fetchHabits()
    }
    
    func deleteHabit(habit: Habit) {
        provider.delete(habit: habit)
        fetchHabits()
    }
    
    // TODO: Service 호출 (오늘 습관 체크, 완료율 계산)
}
