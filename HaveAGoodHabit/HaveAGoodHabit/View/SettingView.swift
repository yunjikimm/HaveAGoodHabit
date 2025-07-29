//
//  SettingView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import SwiftUI

struct SettingView: View {
    private var appVersion: String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "N/A"
        }
        return version
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section("앱 정보") {
                HStack {
                    Text("앱 버전")
                    Spacer()
                    Text(appVersion)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .scrollDisabled(true)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingView()
}
