//
//  HabitCalendarViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/14/25.
//

import Foundation

final class HabitCalendarViewModel: ObservableObject {
    @Published var habit: Habit
    
    private let provider = CoreDataProvider()
    private let service = CalendarService()
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    func toggleHabitDoneToday(selectedDate: Date) {
        service.toggleHabitDoneToday(selectedDate: selectedDate, habit: &habit)
        provider.update(habit: habit)
    }
    
    func isCompleted(date: Date) -> Bool {
        service.isCompleted(date: date, habit: habit)
    }
}
