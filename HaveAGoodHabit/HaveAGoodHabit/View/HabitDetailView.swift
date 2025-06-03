//
//  HabitDetailView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/6/25.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: Habit
    
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    @StateObject private var habitCalendarViewModel: HabitCalendarViewModel
    
    @State private var isShowEditModal: Bool = false
    @State private var isShowDeleteAlert: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    init(habit: Habit) {
        self.habit = habit
        self._habitCalendarViewModel = StateObject(wrappedValue: HabitCalendarViewModel(habit: habit))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(habit.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(DateFormatterToString.yearMonthDay(date: habit.startDate) + " ~ " + DateFormatterToString.yearMonthDay(date: habit.endDate))
                        .badgeBackground()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .roundRectangleBackground()
                
                HabitCalendarView(habitCalendarViewModel: habitCalendarViewModel)
                    .roundRectangleBackground()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemBackground))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("수정") {
                        isShowEditModal.toggle()
                    }
                    
                    Button("삭제", role: .destructive) {
                        isShowDeleteAlert.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .fullScreenCover(isPresented: $isShowEditModal) {
            NavigationStack {
                HabitFormView(mode: HabitFormMode.edit(habit))
            }
        }
        .alert("이 습관을 삭제할까요?", isPresented: $isShowDeleteAlert) {
            Button("삭제", role: .destructive) {
                habitListviewModel.delete(habit: habit)
                habitListviewModel.fetchAll()
                
                dismiss()
            }
            Button("취소", role: .cancel) {}
        }
        .onChange(of: habit) { newValue in
            habitCalendarViewModel.fetchHabitForCalendar(newValue)
        }
    }
}
