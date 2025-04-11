//
//  HabitEntity+CoreData.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/10/25.
//

import CoreData

final class HabitEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var createdAt: Date
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    @NSManaged var doneDates: [Date]
}

extension HabitEntity {
    func toDomain() -> Habit {
        return Habit(
            id: id,
            name: name,
            createdAt: createdAt,
            startDate: startDate,
            endDate: endDate,
            doneDates: doneDates
        )
    }
    
    func update(with domain: Habit) {
        self.id = domain.id
        self.name = domain.name
        self.createdAt = domain.createdAt
        self.startDate = domain.startDate
        self.endDate = domain.endDate
        self.doneDates = domain.doneDates
    }
}
