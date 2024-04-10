//
//  NutritionViewModel.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-04-10.
//

import Foundation
import FirebaseFirestore

class NutritionViewModel: ObservableObject {
    @Published var breakfastData: [MealData] = []
    @Published var lunchData: [MealData] = []
    @Published var dinnerData: [MealData] = []
    @Published var snackData: [MealData] = []

    private var listeners: [ListenerRegistration] = []
    private let userId: String
    private let dateFormatter = DateFormatter()

    init(userId: String) {
        self.userId = userId
        dateFormatter.dateFormat = "yyyyMMdd"
        fetchMeals(for: Date())
    }

    func fetchMeals(for date: Date) {
        let dateString = dateFormatter.string(from: date)

        listeners.forEach { $0.remove() }
        listeners = []

        listeners.append(MealDataManager.observeMealData(userId: userId, date: dateString, mealType: "breakfast") { meals in
            self.breakfastData = meals
        })

        listeners.append(MealDataManager.observeMealData(userId: userId, date: dateString, mealType: "lunch") { meals in
            self.lunchData = meals
        })

        listeners.append(MealDataManager.observeMealData(userId: userId, date: dateString, mealType: "dinner") { meals in
            self.dinnerData = meals
        })

        listeners.append(MealDataManager.observeMealData(userId: userId, date: dateString, mealType: "snack") { meals in
            self.snackData = meals
        })
    }

    deinit {
        listeners.forEach { $0.remove() }
    }
}
