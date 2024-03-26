//
//  AddMealView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-22.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.presentationMode) var presentationMode
    var userId: String
    var date: String
    var mealType: String
    @State private var calories: Double = 0
    @State private var proteins: Double = 0
    @State private var carbs: Double = 0
    @State private var fats: Double = 0
    @State private var name: String = ""
    

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Calories", value: $calories, formatter: NumberFormatter())
                TextField("Proteins", value: $proteins, formatter: NumberFormatter())
                TextField("Carbs", value: $carbs, formatter: NumberFormatter())
                TextField("Fats", value: $fats, formatter: NumberFormatter())
                Button("Save Meal") {
                    saveMealData()
                }
            }
            .navigationTitle("Add \(mealType) Meal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func saveMealData() {

        let mealData = MealData(
            id: "",
            carbs: carbs,
            fats: fats,
            proteins: proteins,
            calories: calories,
            name: name
        )
        print("Saving meal data with mealType: \(mealType)")
        MealDataManager.insertMealData(userId: userId, date: date, mealType: mealType.lowercased(), mealData: mealData)
                presentationMode.wrappedValue.dismiss()
    }
}
