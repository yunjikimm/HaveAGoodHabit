//
//  CompletionLevel.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/25/25.
//

enum CompletionLevel: String {
    case veryLow = "rate-icon-0"
    case low     = "rate-icon-1"
    case medium  = "rate-icon-2"
    case high    = "rate-icon-3"

    static func from(rate: Double) -> CompletionLevel {
        if rate == 1 {
            return .high
        } else if rate > 0.49 {
            return .medium
        } else if rate > 0.19 {
            return .low
        } else {
            return .veryLow
        }
    }
}

