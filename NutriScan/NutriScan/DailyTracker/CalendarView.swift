import SwiftUI

struct CalendarView: View {
    let days: [Date]
    @Binding var selectedDate: Date

    private let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d" // Format for month and day
        return formatter
    }()

    var body: some View {
        // Wrap the ScrollView in a ScrollViewReader
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(days.indices, id: \.self) { index in
                        let day = days[index]
                        Button(action: {
                            selectedDate = day
                        }) {
                            Text(dayMonthFormatter.string(from: day)) // Use the custom formatter
                                .padding()
                                .background(Calendar.current.isDate(selectedDate, inSameDayAs: day) ? Color(Color("ColorGreenAdaptive")) : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .id(index) // Assign an ID to each Button for ScrollViewProxy to use
                    }
                }
                .padding()
            }
            .onAppear {
                // Scroll to the current date when the view appears
                if let currentIndex = days.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: Date()) }) {
                    withAnimation {
                        scrollViewProxy.scrollTo(currentIndex, anchor: .center)
                    }
                }
            }
        }
    }
}
