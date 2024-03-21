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
            ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 20) {
                           ForEach(days, id: \.self) { day in
                               Button(action: {
                                   selectedDate = day
                               }) {
                                   Text(day, style: .date)
                                       .padding()
                                       .background(Calendar.current.isDate(selectedDate, inSameDayAs: day) ? Color.blue : Color.gray)
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
                           }
                       }
                       .padding()
                   }
               }
           }

//#Preview {
  //  CalendarView()
//}

