//
//  AddHabitView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct AddHabitView: View {
    @State var habitName: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            
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
                
                Button {
                    
                } label: {
                    Text("추가하기")
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.secondary)
                        }
                }

            }
            .padding(.horizontal)
            .navigationTitle("습관 추가하기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddHabitView()
}
