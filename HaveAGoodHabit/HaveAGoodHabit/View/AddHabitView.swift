//
//  AddHabitView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct AddHabitView: View {
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    
    @State var habitName: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @State var newHabit: Habit?
    
    let habitNameEmptyWarningMessage = "습관 이름은 필수 입력 항목입니다."
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading) {
                Text("습관")
                    .font(.caption)
                
                TextField("습관을 입력해주세요.", text: $habitName)
                    .padding(20)
                    .background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.background)
                    }
                
                Text(habitNameEmptyWarningMessage)
                    .font(.caption)
                    .foregroundColor(habitName.isEmpty ? .red : .clear)
            }
            
            VStack(alignment: .leading) {
                Text("기간 설정")
                    .font(.caption)
                
                VStack(spacing: 24) {
                    DatePicker("시작", selection: $startDate, displayedComponents: [.date])
                    DatePicker("종료", selection: $endDate, displayedComponents: [.date])
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
        .navigationTitle("습관 추가하기")
        .navigationBarTitleDisplayMode(.inline)
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
                        newHabit = Habit(id: UUID(), name: habitName, createdAt: Date(), startDate: startDate, endDate: endDate, doneDates: [])
                        
                        guard let newHabit = newHabit else {
                            fatalError("newHabit should not be nil")
                        }
                        
                        habitListviewModel.addHabit(habit: newHabit)
                        dismiss()
                    }
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
