//
//  HabitFormMode.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/13/25.
//

enum HabitFormMode {
    case add
    case edit(Habit)
    
    var name: String {
        switch self {
        case .add:
            return "습관 추가하기"
        case .edit:
            return "습관 수정하기"
        }
    }
}
