//
//  HabitServiceProtocol.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 5/16/25.
//

import Foundation

protocol HabitServiceProtocol {
    func fetchAll() async throws -> [Habit]
    func fetchNextPage() async throws -> [Habit]
    func fetchHabit(id: UUID) async throws -> Habit?
    func save(habit: Habit) async throws
    func update(habit: Habit) async throws
    func delete(habit: Habit) async throws
}
