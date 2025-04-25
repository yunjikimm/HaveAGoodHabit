//
//  HabitCalendarView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

enum CompletionStatus: String {
    case notCompleted = "rate-icon-0"
    case completed = "rate-icon-3"
}

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
                            .foregroundStyle(.secondary)
                    }
                    
                    // 자리 맞춤
                    ForEach(0..<currentMonth.startOffsetOfThisMonth, id: \.self) { month in
                        Circle()
                            .fill(.clear)
                    }
                    
                    // 이번 달 날짜
                    ForEach(currentMonth.dateInThisMonth, id: \.self) { date in
                        let day = date.formattedDateString("dd")
                        
                        VStack {
                            // start ~ end Date 범위에 해당하는 날짜 UI
                            if habitCalendarViewModel.isDateInRange(date: date, start: habitCalendarViewModel.habit.startDate, end: habitCalendarViewModel.habit.endDate) {
                                Image(habitCalendarViewModel.isCompleted(date: date) ? CompletionStatus.completed.rawValue : CompletionStatus.notCompleted.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 44, height: 44)
                                    .onTapGesture {
                                        selectedDate = date
                                        guard let selectedDate = selectedDate else { return }
                                        habitCalendarViewModel.toggleHabitDoneToday(selectedDate: selectedDate)
                                        habitCalendarViewModel.calculateCompletionRate()
                                    }
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
        .onDisappear {
            habitListviewModel.fetchHabits()
        }
    }
}
