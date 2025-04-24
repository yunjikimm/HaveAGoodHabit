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
        NavigationLink(destination: HabitDetailView(habit: habit)) {
            HStack {
                if habit.completionRate > 0.89 {
                    Circle()
                        .fill(.green.opacity(0.9))
                        .frame(width: 44, height: 44)
                } else if habit.completionRate > 0.59 {
                    Circle()
                        .fill(.green.opacity(0.6))
                        .frame(width: 44, height: 44)
                } else if habit.completionRate > 0.29 {
                    Circle()
                        .fill(.green.opacity(0.3))
                        .frame(width: 44, height: 44)
                } else {
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .frame(width: 44, height: 44)
                }
                
                Text(habit.name)
            }
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
