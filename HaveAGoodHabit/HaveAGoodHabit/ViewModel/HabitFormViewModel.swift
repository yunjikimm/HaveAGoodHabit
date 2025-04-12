//
//  HabitFormViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/13/25.
//

import Foundation

final class HabitFormViewModel: ObservableObject {
    @Published var habit: Habit
    
    init(habit: Habit?) {
        if let habit = habit {
            self.habit = habit
        } else {
            self.habit = Habit(id: UUID(), name: "", createdAt: Date(), startDate: Date(), endDate: Date(), doneDates: [])
        }
    }
    
    func updateHabit(name: String, startDate: Date, endDate: Date) -> Habit {
        return Habit(id: habit.id, name: name, createdAt: Date(), startDate: startDate, endDate: endDate, doneDates: habit.doneDates)
    }
}
