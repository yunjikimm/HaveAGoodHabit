//
//  CoreDataProviderProtocol.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 5/16/25.
//

import Foundation

protocol CoreDataProviderProtocol {
    func fetchAll(limit: Int, offset: Int) -> [Habit]
    func fetchHabit(id: UUID) -> Habit
    func save(habit: Habit)
    func update(habit: Habit)
    func delete(habit: Habit)
}
