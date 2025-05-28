//
//  HabitFormViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/13/25.
//

import Foundation

final class HabitFormViewModel: ObservableObject {
    @Published var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    func updateHabit(name: String, startDate: Date, endDate: Date) -> Habit {
        habit.name = name
        habit.startDate = startDate
        habit.endDate = endDate
        
        return habit
    }
}
