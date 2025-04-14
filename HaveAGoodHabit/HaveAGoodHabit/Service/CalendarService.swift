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
    
    func isCompleted(date: Date, habit: Habit) -> Bool {
        habit.doneDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) })
    }
}
