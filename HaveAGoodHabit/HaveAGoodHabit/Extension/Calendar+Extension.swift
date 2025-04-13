//
//  Calendar+Extension.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/13/25.
//

import Foundation

extension Calendar {
    func isDateInRange(date: Date, start: Date, end: Date) -> Bool {
        let start = self.startOfDay(for: start)
        let end = self.startOfDay(for: end)
        let current = self.startOfDay(for: date)
        return current >= start && current <= end
    }
}
