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
            VStack {
                if habitListviewModel.habits.isEmpty {
                    EmptyHabitListView()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(habitListviewModel.habits) { habit in
                                HabitListCellView(habit: habit)
                                    .background(Color(.secondarySystemBackground))
                                    .onAppear {
                                        guard let lastIndex = habitListviewModel.habits.last else { return }
                                        
                                        if habit.id == lastIndex.id {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                habitListviewModel.fetchNextPage()
                                            }
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .background(Color(.secondarySystemBackground))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("main-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
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
