//
//  MealSectionView.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-21.
//

import SwiftUI

struct MealSectionView: View {
    let mealType: String
    let meals: [MealData]
    @Binding var showAddMealView: Bool

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
                Button(action: {
                    // Handle meal cancellation
                }) {
                    Image(systemName: "xmark.circle")
                }
            }
        }
            }
        }

//#Preview {
  //  MealSectionView()
//}
