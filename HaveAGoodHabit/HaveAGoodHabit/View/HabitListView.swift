//
//  HabitListView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/5/25.
//

import SwiftUI

struct HabitListView: View {
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    
    @State var isShowAddHabitView: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Text("Habit List")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                if habitListviewModel.habits.isEmpty {
                    Text("no data")
                } else {
                    ForEach(habitListviewModel.habits) { habit in
                        VStack {
                            NavigationLink(destination: HabitDetailView(habit: habit)) {
                                HabitListCellView(habit: habit)
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground))
            .navigationTitle("HAVE A GOOD HABIT")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowAddHabitView.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape")
                            .foregroundStyle(.primary)
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowAddHabitView) {
                NavigationStack {
                    HabitFormView(mode: HabitFormMode.add, habitFormViewModel: HabitFormViewModel(habit: nil))
                }
            }
        }
        .onAppear {
            habitListviewModel.fetchHabits()
        }
    }
}

#Preview {
    HabitListView()
}
