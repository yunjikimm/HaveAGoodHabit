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
                        let day = DateFormatterToString.day(date: date)
                        
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
                                        
                                        if habitCalendarViewModel.isToday(date: date) {
                                            habitCalendarViewModel.toggleHabitDoneToday(selectedDate: selectedDate)
                                            habitCalendarViewModel.calculateCompletionRate()
                                            
                                            habitListviewModel.update(habit: habitCalendarViewModel.habit)
                                        }
                                    }
                                    .onChange(of: selectedDate) { _ in
                                        habitListviewModel.fetchHabit(id: habitCalendarViewModel.habit.id)
                                    }
                            } else {
                                Circle()
                                    .fill(.clear)
                            }
                            
                            Text(day)
                                .font(.caption)
                                .padding(4)
                                .background {
                                    Circle()
                                    .fill(habitCalendarViewModel.isToday(date: date) ? Color.secondary : Color.clear)
                                }
                        }
                    }
                }
            }
        }
    }
}
