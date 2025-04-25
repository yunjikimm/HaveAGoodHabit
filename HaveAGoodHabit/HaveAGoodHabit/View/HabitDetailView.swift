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
    
    @State private var isShowEditModal: Bool = false
    @State private var isShowDeleteAlert: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(habit.startDate.formattedDateString("yyyy년 MM월 dd일") + " ~ " + habit.endDate.formattedDateString("yyyy년 MM월 dd일"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                
                HabitCalendarView(habitCalendarViewModel: HabitCalendarViewModel(habit: habit))
                    .padding(.vertical, 24)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.background)
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .scrollIndicators(.hidden)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemBackground))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
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
                HabitFormView(mode: HabitFormMode.edit, habitFormViewModel: HabitFormViewModel(habit: habit))
            }
        }
        .alert("이 습관을 삭제할까요?", isPresented: $isShowDeleteAlert) {
            Button("삭제", role: .destructive) {
                habitListviewModel.deleteHabit(habit: habit)
                dismiss()
            }
            Button("취소", role: .cancel) {}
        }
    }
}
