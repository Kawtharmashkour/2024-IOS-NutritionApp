//
//  MealViewModel.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-04-09.
//

import Foundation
class MealViewModel: ObservableObject {
    @Published var breakfastData: [MealData] = []
    @Published var lunchData: [MealData] = []
    @Published var dinnerData: [MealData] = []
    @Published var snackData: [MealData] = []

    func fetchData(userId: String, date: String) {
        MealDataManager.fetchMealData(userId: userId, date: date, mealType: "breakfast") { meals in
            DispatchQueue.main.async {
                self.breakfastData = meals
            }
        }
        // Repeat for lunch, dinner, and snack...
    }

    func insertMealData(userId: String, mealData: RecipeViewModel, mealType: String) {
        MealDataManager.insertMealData(userId: userId, mealData: mealData, mealType: mealType) {
            // Trigger data refresh after successful insertion
            self.fetchData(userId: userId, date: DateFormatter().string(from: Date()))
        }
    }
}

