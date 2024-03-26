//
//  MealSectionView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-21.
//

import SwiftUI

struct MealSectionView: View {
    let mealType: String
    @Binding var meals: [MealData]
    @Binding var showAddMealView: Bool
    let userId: String

    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Text(mealType)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            showAddMealView = true
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                       
                    
                    HStack {
                        VStack{
                            Text("Calories")
                            Text("\(meals.reduce(0) { $0 + $1.calories }, specifier: "%.2f")")
                        }
                        Spacer()
                        
                        VStack{
                            Text("Proteins")
                            Text("\(meals.reduce(0) { $0 + $1.proteins }, specifier: "%.2f")")
                        }
                        Spacer()
                        
                        VStack{
                            Text("Carbs")
                            Text("\(meals.reduce(0) { $0 + $1.carbs }, specifier: "%.2f")")
                        }
                        Spacer()
                        
                        VStack{
                            Text("Fat")
                            Text("\(meals.reduce(0) { $0 + $1.fats }, specifier: "%.2f")")
                        }
                        
                    }
                }
                .padding()
        // Display each meal item
        ForEach(meals, id: \.id) { meal in
            HStack {
                Text(meal.name)
                Spacer()
                if let imageUrl = URL(string: meal.image) {
                    AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 30, height: 30) // Adjust the size as needed
                        .clipShape(Circle()) // Optional: make the image circular
                    }
                Spacer()
                Button(action: {
                    if let mealId = meal.id {
                           deleteMeal(mealId: mealId)
                       }
                }) {
                    Image(systemName: "xmark.circle")
                }
            }
        }
            }
    private func deleteMeal(mealId: String) {
        MealDataManager.deleteMealData(userId: userId, mealId: mealId) { success in
               if success {
                   meals.removeAll { $0.id == mealId }
               }
           }
    }

        }

//#Preview {
  //  MealSectionView()
//}
