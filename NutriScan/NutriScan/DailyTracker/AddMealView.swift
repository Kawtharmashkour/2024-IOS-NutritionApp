//
//  AddMealView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-22.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var mealType: String = "Breakfast"
    @State private var calories: Double = 0
    @State private var proteins: Double = 0
    @State private var carbs: Double = 0
    @State private var fats: Double = 0
    @State private var name: String = ""
    @State private var image: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Calories", value: $calories, formatter: NumberFormatter())
                TextField("Proteins", value: $proteins, formatter: NumberFormatter())
                TextField("Carbs", value: $carbs, formatter: NumberFormatter())
                TextField("Fats", value: $fats, formatter: NumberFormatter())
                TextField("Image URL", text: $image)
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
        let userId = "DDVmxDPbFZZhEs4QebM8HTQQLVi1"  // Replace with the actual user ID
        let dateString = "20240322"  // Example date, use your own logic to get the date string

        let mealData = MealData(
            id: "",
            carbs: carbs,
            fats: fats,
            proteins: proteins,
            calories: calories,
            name: name,
            image: image
        )

        MealDataManager.insertMealData(userId: userId, date: dateString, mealType: mealType.lowercased(), mealData: mealData)
        presentationMode.wrappedValue.dismiss()
    }
}
