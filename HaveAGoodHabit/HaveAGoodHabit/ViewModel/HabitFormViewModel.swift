//
//  HabitFormViewModel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/13/25.
//

import Foundation

final class HabitFormViewModel: ObservableObject {
    @Published var habit: Habit
    
    init(mode: HabitFormMode) {
        switch mode {
        case .add:
            self.habit = Habit(id: UUID(), name: "", createdAt: Date(), startDate: Date(), endDate: Date(), doneDates: [], completionRate: 0)
        case .edit(let habit):
            self.habit = habit
        }
    }
    
    func updateHabit(name: String, startDate: Date, endDate: Date) -> Habit {
        habit.name = name
        habit.startDate = startDate
        habit.endDate = endDate
        
        return habit
    }
}
