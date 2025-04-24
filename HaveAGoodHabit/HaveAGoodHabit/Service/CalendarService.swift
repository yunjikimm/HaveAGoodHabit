//
//  CalendarService.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/14/25.
//

import Foundation

struct CalendarService {
    func toggleHabitDoneToday(selectedDate: Date, habit: inout Habit) {
        if let index = habit.doneDates.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: selectedDate) }) {
            habit.doneDates.remove(at: index)
        } else {
            habit.doneDates.append(selectedDate)
        }
    }
    
    func isDateInRange(date: Date, start: Date, end: Date) -> Bool {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: start)
        let end = calendar.startOfDay(for: end)
        let current = calendar.startOfDay(for: date)
        return current >= start && current <= end
    }
    
    func isCompleted(date: Date, habit: Habit) -> Bool {
        habit.doneDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })
    }
    
    func calculateCompletionRate(habit: Habit) -> Double {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: habit.startDate)
        let end = calendar.startOfDay(for: habit.endDate)
        guard let totalDays = calendar.dateComponents([.day], from: start, to: end).day else {
            return 0
        }
        
        let activeDays = totalDays + 1
        
        let completedDays = habit.doneDates.filter {
            calendar.startOfDay(for: $0) <= end
        }.count
        
        return activeDays == 0 ? 0 : Double(completedDays) / Double(activeDays)
    }
}
