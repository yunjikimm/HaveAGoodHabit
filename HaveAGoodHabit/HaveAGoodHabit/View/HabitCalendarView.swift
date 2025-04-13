//
//  HabitCalendarView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct HabitCalendarView: View {
    let habit: Habit
    
    @State private var currentMonth: Date = Date()
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button {
                    currentMonth = currentMonth.previousMonth
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(currentMonth.startDateOfThisMonth.formattedDateString("yyyy년 MM월"))

                Spacer()
                
                Button {
                    currentMonth = currentMonth.nextMonth
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            
            VStack {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7)) {
                    // 요일
                    ForEach(Weekday.allCases, id: \.rawValue) { weekday in
                        Text(weekday.rawValue)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // 자리 맞춤 용
                    ForEach(0..<currentMonth.startOffsetOfThisMonth, id: \.self) { month in
                        Circle()
                            .fill(.clear)
                    }
                    
                    // 이번 달 날짜
                    ForEach(currentMonth.dateInThisMonth, id: \.self) { date in
                        let day = date.formattedDateString("dd")
                        
                        VStack {
                            // start ~ end Date 범위에 해당하는 날짜 UI
                            if Calendar.current.isDateInRange(date: date, start: habit.startDate, end: habit.endDate) {
                                Circle()
                                    .fill(.secondary)
                                    .frame(width: 44, height: 44)
                            } else {
                                Circle()
                                    .fill(.clear)
                            }
                            
                            Text(day)
                                .font(.caption)
                                .padding(4)
                                .background {
                                    if (Calendar.current.isDate(date, inSameDayAs: Date.now)) {
                                        Circle()
                                            .fill(.secondary)
                                    } else {
                                        Circle()
                                            .fill(.clear)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}
