//
//  SettingView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("앱 정보") {
                Text("앱 버전")
            }
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingView()
}
