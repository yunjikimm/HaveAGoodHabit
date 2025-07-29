//
//  HabitCalendarViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/14/25.
//

import Foundation

final class HabitCalendarViewModel: ObservableObject {
    @Published var habit: Habit
    
    private let service: CalendarService
    
    init(habit: Habit, service: CalendarService = CalendarService()) {
        self.habit = habit
        self.service = service
    }
    
    func fetchHabitForCalendar(_ newHabit: Habit) {
        self.habit = newHabit
    }
    
    func toggleHabitDoneToday(selectedDate: Date) {
        service.toggleHabitDoneToday(selectedDate: selectedDate, habit: &habit)
    }
    
    func isToday(date: Date) -> Bool {
        service.isToday(date: date)
    }
    
    func isDateInRange(date: Date, start: Date, end: Date) -> Bool {
        service.isDateInRange(date: date, start: start, end: end)
    }
    
    func isCompleted(date: Date) -> Bool {
        service.isCompleted(date: date, habit: habit)
    }
    
    func calculateCompletionRate() {
        habit.completionRate = service.calculateCompletionRate(habit: habit)
    }
}
