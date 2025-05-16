//
//  HabitServiceProtocol.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 5/16/25.
//

import Foundation

protocol HabitServiceProtocol {
    func fetchAll() -> [Habit]
    func fetchNextPage() -> [Habit]
    func fetchHabit(id: UUID) -> Habit?
    func save(habit: Habit)
    func update(habit: Habit)
    func delete(habit: Habit)
}
