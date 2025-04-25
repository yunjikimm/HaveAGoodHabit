//
//  HabitFormView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import SwiftUI

struct HabitFormView: View {
    let mode: HabitFormMode
    
    @ObservedObject var habitFormViewModel: HabitFormViewModel
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    
    @State var habitName: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    let habitNameEmptyWarningMessage = "습관 이름은 필수 입력 항목입니다."
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 34) {
            VStack(alignment: .leading) {
                Text("습관")
                    .font(.caption)
                
                TextField("습관을 입력해주세요.", text: $habitName)
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.background)
                    }
                    .onChange(of: habitName) { newValue in
                        if newValue.count > 20 {
                            habitName = String(newValue.prefix(20))
                        }
                    }
                
                HStack {
                    Text(habitNameEmptyWarningMessage)
                        .font(.caption)
                        .foregroundColor(habitName.isEmpty ? .red : .clear)
                    
                    Spacer()
                        
                    Text("\(habitName.count) / 20")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            VStack(alignment: .leading) {
                Text("기간 설정")
                    .font(.caption)
                
                VStack(spacing: 24) {
                    DatePicker("시작", selection: $startDate, in: Date()..., displayedComponents: .date)
                    DatePicker("종료", selection: $endDate, in: startDate..., displayedComponents: .date)
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.background)
                }
            }
            
            Spacer()

        }
        .padding(.horizontal)
        .background(Color(.secondarySystemBackground))
        .navigationTitle(mode.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            habitName = habitFormViewModel.habit.name
            startDate = habitFormViewModel.habit.startDate
            endDate = habitFormViewModel.habit.endDate
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if !habitName.isEmpty {
                        switch mode {
                        case .add:
                            let newHabit = Habit(id: UUID(), name: habitName, createdAt: Date(), startDate: startDate, endDate: endDate, doneDates: [], completionRate: 0.0)
                            
                            habitListviewModel.addHabit(habit: newHabit)
                        case .edit:
                            let editHbit = habitFormViewModel.updateHabit(name: habitName, startDate: startDate, endDate: endDate)
                            
                            habitListviewModel.updateHabit(habit: editHbit)
                        }
                        dismiss()
                    }
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
