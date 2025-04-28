//
//  BadgeBackgroundModifier.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/28/25.
//

import SwiftUI

struct BadgeBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.secondarySystemBackground))
            }
    }
}

extension View {
    func badgeBackground() -> some View {
        modifier(BadgeBackgroundModifier())
    }
}
