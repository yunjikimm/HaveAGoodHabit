//
//  DateFormatterToString.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/28/25.
//

import Foundation

enum DateFormatterToString {
    static func formatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter
    }
    
    static func yearMonthDay(date: Date) -> String {
        formatter(format: "yyyy. MM. dd.").string(from: date)
    }
    
    static func yearMonth(date: Date) -> String {
        formatter(format: "yyyy. MM.").string(from: date)
    }
    
    static func day(date: Date) -> String {
        formatter(format: "dd").string(from: date)
    }
}
