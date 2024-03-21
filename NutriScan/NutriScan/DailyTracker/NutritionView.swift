//
//  NutritionView.swift
//  Callories
//
//  Created by behnaz Khalili on 2024-03-18.
//

import SwiftUI

struct NutritionView: View {
    @State private var selectedDate: Date = Date()
    var body: some View {
        NavigationView {
                    VStack {
                        // Calendar navigation bar
                        CalendarView(days: generateDays(), selectedDate: $selectedDate)
                                   
                                   Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                                       .padding()
                        
                        // Nutritional elements circular graph
                        NutritionalGraphView()
                        
                        // Breakfast section
                        //MealSectionView(mealType: "Breakfast", goalCalories: 545, items: [
                          //  MealItem(name: "Fried Egg", calories: 91.94, protein: 6.26, carbs: //0.92, fat: 6.83),
                            //MealItem(name: "Hot Tea", calories: 0, protein: 0, carbs: 0, fat: 0)
                        //])
                        
                        // Lunch section (partially visible)
                        //MealSectionView(mealType: "Lunch", goalCalories: 954, items: [
                            // Add your lunch items here
                        //])
                        
                        Spacer()
                    }
                    .navigationTitle("Today")
                }
            }
        }
private func generateDays() -> [Date] {
        let today = Date()
        let calendar = Calendar.current
        let range = -45...45
        return range.map { calendar.date(byAdding: .day, value: $0, to: today)! }
    }


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

#Preview {
    NutritionView()
}
