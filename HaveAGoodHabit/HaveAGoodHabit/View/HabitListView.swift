//
//  HabitListView.swift
//  HaveAGoodHabit
//
//  Created by 김윤지 on 4/5/25.
//

import SwiftUI

struct HabitListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    HStack {
                        Text("Habit List")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    ForEach(0..<5) { _ in
                        VStack {
                            NavigationLink(destination: Text("Details")) {
                                HabitListCellView()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
                .navigationTitle("HAVE A GOOD HABIT")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: Text("Add Habit")) {
                            Image(systemName: "plus.app")
                                .foregroundStyle(.primary)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: Text("Setting")) {
                            Image(systemName: "gearshape")
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HabitListView()
}
