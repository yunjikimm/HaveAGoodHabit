//
//  HaveAGoodHabitApp.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/3/25.
//

import SwiftUI

@main
struct HaveAGoodHabitApp: App {
    @StateObject var habitListViewModel = HabitListViewModel()
    
    var body: some Scene {
        WindowGroup {
            HabitListView()
                .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
                .environmentObject(habitListViewModel)
        }
    }
}
