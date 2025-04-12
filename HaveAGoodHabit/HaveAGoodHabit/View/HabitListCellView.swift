//
//  HabitListCellView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/5/25.
//

import SwiftUI

struct HabitListCellView: View {
    let habit: Habit
    
    var body: some View {
        VStack {
            Text(habit.name)
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.background)
        }
    }
}
