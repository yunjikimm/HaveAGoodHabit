import SwiftUI

struct HabitCalendarDayCellView: View {
    @EnvironmentObject var habitListviewModel: HabitListViewModel
    @ObservedObject var viewModel: HabitCalendarViewModel
    
    let date: Date

    var body: some View {
        VStack {
            if viewModel.isDateInRange(date: date, start: viewModel.habit.startDate, end: viewModel.habit.endDate) {
                Image(viewModel.isCompleted(date: date)
                      ? CompletionStatus.completed.rawValue
                      : CompletionStatus.notCompleted.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        if date.isToday(date: date) {
                            let selectedDate = date
                            Task {
                                viewModel.toggleHabitDoneToday(selectedDate: selectedDate)
                                viewModel.calculateCompletionRate()
                                try await habitListviewModel.update(habit: viewModel.habit)
                            }
                        }
                    }

            } else {
                Circle().fill(.clear)
            }

            Text(DateFormatterToString.day(date: date))
                .font(.caption)
        }
    }
}
