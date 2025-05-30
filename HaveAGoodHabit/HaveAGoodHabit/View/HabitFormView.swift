//
//  HabitFormView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/12/25.
//

import SwiftUI

struct HabitFormView: View {
    let mode: HabitFormMode
    
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    @StateObject var habitFormViewModel: HabitFormViewModel
    
    init(mode: HabitFormMode) {
        self.mode = mode
        self._habitFormViewModel = StateObject(wrappedValue: HabitFormViewModel(mode: mode))
    }
    
    @State var habitName: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 34) {
            VStack(alignment: .leading) {
                Text("습관")
                    .font(.caption)
                    .padding(.leading, 4)
                
                TextField(FormNoticeMessage.habitNamePlaceholder.rawValue, text: $habitName)
                    .roundRectangleBackground()
                    .onChange(of: habitName) { newValue in
                        if newValue.count > 20 {
                            habitName = String(newValue.prefix(20))
                        }
                    }
                
                HStack {
                    Text(FormNoticeMessage.habitNameEmpty.rawValue)
                        .font(.caption)
                        .foregroundColor(habitName.isEmpty ? .red : .clear)
                    
                    Spacer()
                        
                    Text("\(habitName.count) / 20")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 4)
            }
            
            VStack(alignment: .leading) {
                Text("기간 설정")
                    .font(.caption)
                    .padding(.leading, 4)
                
                VStack(spacing: 24) {
                    DatePicker("시작", selection: $startDate, in: Date()..., displayedComponents: .date)
                    DatePicker("종료", selection: $endDate, in: startDate..., displayedComponents: .date)
                }
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .roundRectangleBackground()
            }
            
            Spacer()

        }
        .padding(.horizontal, 8)
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
                            
                            habitListviewModel.save(habit: newHabit)
                        case .edit:
                            let editHbit = habitFormViewModel.updateHabit(name: habitName, startDate: startDate, endDate: endDate)
                            
                            habitListviewModel.update(habit: editHbit)
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
