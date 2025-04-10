//
//  Habit.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/10/25.
//

import Foundation

struct Habit: Identifiable {
    var id: UUID
    var name: String
    var createdAt: Date
    var startDate: Date
    var endDate: Date
    var doneDates: [Date]
    
    var isNameValid: Bool {
        !name.isEmpty
    }
}
