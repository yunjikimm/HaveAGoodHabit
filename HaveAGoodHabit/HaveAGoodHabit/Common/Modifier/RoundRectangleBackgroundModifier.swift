//
//  RoundRectangleBackgroundModifier.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/28/25.
//

import SwiftUI

struct RoundRectangleBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 20)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.background)
            }
    }
}

extension View {
    func roundRectangleBackground() -> some View {
        modifier(RoundRectangleBackgroundModifier())
    }
}
