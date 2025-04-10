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
