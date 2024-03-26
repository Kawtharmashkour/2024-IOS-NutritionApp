//
//  CalendarView.swift
//  Callories
//
//  Created by behnaz Khalili on 2024-03-18.
//
import SwiftUI

struct CalendarView: View {
    let days: [Date]
    @Binding var selectedDate: Date


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
                            Text(day, style: .date)
                                .padding()
                                .background(Calendar.current.isDate(selectedDate, inSameDayAs: day) ? Color.blue : Color.gray)
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
//#Preview {
  //  CalendarView()
//}

