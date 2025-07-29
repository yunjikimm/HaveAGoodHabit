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
            HStack(spacing: 20) {
                Image(CompletionLevel.from(rate: habit.completionRate).rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("\(Int(habit.completionRate * 100))%")
                            .badgeBackground()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                            Text("\(habit.doneDates.count)")
                        }
                        .badgeBackground()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .roundRectangleBackground()
        }
    }
}
