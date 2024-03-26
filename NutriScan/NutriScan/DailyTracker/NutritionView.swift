//
//  NutritionView.swift
//  Callories
//
//  Created by behnaz Khalili on 2024-03-18.
//

import SwiftUI

struct NutritionView: View {
    @State private var selectedDate: Date = Date()
    @State private var breakfastData: [MealData] = []
    @State private var lunchData: MealData?
    @State private var dinnerData: MealData?
    @State private var showAddMealView = false
    @State private var showSettings = false
    var body: some View {
        NavigationView {
            // ScrollView {
            VStack {
                // Calendar navigation bar
                CalendarView(days: generateDays(), selectedDate: $selectedDate)
                
                Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                    .padding()
                
                // Nutritional elements circular graph
                NutritionalGraphView()
                Divider()
                Spacer()
                VStack{
                    MealSectionView(
                        mealType: "Breakfast",
                        meals: $breakfastData,  // Pass the array of breakfast items
                        showAddMealView: $showAddMealView,
                        userId: "DDVmxDPbFZZhEs4QebM8HTQQLVi1" 
                    )
                    .sheet(isPresented: $showAddMealView) {
                        AddMealView()
                    }
                    /*  MealSectionView(mealType: "Lunch", calories: lunchData?.calories ?? 0, proteins: lunchData?.proteins ?? 0, carbs: lunchData?.carbs ?? 0, fat: lunchData?.fat ?? 0)
                     MealSectionView(mealType: "Dinner", calories: dinnerData?.calories ?? 0, proteins: dinnerData?.proteins ?? 0, carbs: dinnerData?.carbs ?? 0, fat: dinnerData?.fat ?? 0)*/
                }
                
                
            }
            .navigationTitle("Today")
            .toolbar {
                // Add a button on the top right of the toolbar to go to the settings
                NavigationLink(destination: 
                                SettingView(), isActive: $showSettings) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.blue)
                    }
                }
                                .onAppear {
                                    let userId = "DDVmxDPbFZZhEs4QebM8HTQQLVi1"  // Replace with the actual user ID
                                    let dateString = "20240322"  // Example date, use your own logic to get the date string
                                    
                                    MealDataManager.fetchMealData(userId: userId, date: dateString, mealType: "breakfast") { meals in
                                        breakfastData = meals
                                    }
                                }
                
            }
        }
    }
    private func generateDays() -> [Date] {
        let today = Date()
        let calendar = Calendar.current
        let range = -15...15
        return range.map { calendar.date(byAdding: .day, value: $0, to: today)! }
    }
    //}
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
#Preview {
    NutritionView()
}
