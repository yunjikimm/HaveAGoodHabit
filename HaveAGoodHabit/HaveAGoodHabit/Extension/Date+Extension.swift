//
//  Date+Extension.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/7/25.
//

import Foundation

extension Date {
    // 이번 달의 첫 날
    var startDateOfThisMonth: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            fatalError("cannot retrieve start of this month")
        }
        return date
    }
    
    // 이번 달의 날짜들
    var dateInThisMonth: [Date] {
        guard let range = Calendar.current.range(of: .day, in: .month, for: self) else {
            fatalError("cannot retrieve date in this month")
        }
        return range.compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: startDateOfThisMonth)
        }
    }
    
    // 날짜 요일 맞추기
    var startOffsetOfThisMonth: Int {
        Calendar.current.component(.weekday, from: startDateOfThisMonth) - 1
    }
    
    // 저번 달
    var previousMonth: Date {
        guard let month = Calendar.current.date(byAdding: .month, value: -1, to: self) else {
            fatalError("cannot retrieve previous month")
        }
        
        return month
    }
    
    // 이번 달
    var nextMonth: Date {
        guard let month = Calendar.current.date(byAdding: .month, value: 1, to: self) else {
            fatalError("cannot retrieve next month")
        }
        
        return month
    }
}
