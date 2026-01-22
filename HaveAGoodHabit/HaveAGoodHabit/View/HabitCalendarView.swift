//
//  HabitCalendarView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct HabitCalendarView: View {
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    @ObservedObject var habitCalendarViewModel: HabitCalendarViewModel
    
    @State private var currentMonth: Date = Date()
    @State var selectedDate: Date?
    
    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button {
                    currentMonth = currentMonth.previousMonth
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(DateFormatterToString.yearMonth(date: currentMonth.startDateOfThisMonth))
                    .fontWeight(.bold)

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
                            .foregroundStyle(.secondary)
                    }
                    
                    // 자리 맞춤
                    ForEach(0..<currentMonth.startOffsetOfThisMonth, id: \.self) { month in
                        Circle()
                            .fill(.clear)
                    }
                    
                    // 이번 달 날짜
                    ForEach(currentMonth.dateInThisMonth, id: \.self) { date in
                        HabitCalendarDayCellView(viewModel: habitCalendarViewModel, date: date)
                    }
                }
            }
        }
    }
}
