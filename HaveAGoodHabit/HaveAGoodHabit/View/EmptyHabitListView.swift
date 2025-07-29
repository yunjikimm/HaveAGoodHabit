//
//  EmptyHabitListView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/25/25.
//

import SwiftUI

struct EmptyHabitListView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("rate-icon-0")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
            
            Text("아직 등록한 습관이 없어요.")
            
            VStack {
                HStack {
                    Image(systemName: "plus.app")
                    Text("버튼을 눌러")
                }
                Text("새로운 습관을 만들어 보세요!")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .roundRectangleBackground()
    }
}

#Preview {
    EmptyHabitListView()
}
