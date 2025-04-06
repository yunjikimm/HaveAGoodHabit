//
//  EditHabitView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct EditHabitView: View {
    @State var habitName: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    Spacer()
                    
                    Text("습관 수정하기")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                    }

                }
                
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

            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    EditHabitView()
}
