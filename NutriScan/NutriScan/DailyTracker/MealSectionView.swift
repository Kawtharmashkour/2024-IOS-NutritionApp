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
    @Binding var currentMealType: String? 
    let userId: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(mealType)
                
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    self.currentMealType = mealType
                    self.showAddMealView = true
                    
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
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
            List{
                ForEach(meals, id: \.id) { meal in
                    HStack {
                        Text(meal.name)
                        Spacer()
                      
                    }
                }.onDelete(perform: deleteMeal)
            }
        }
    }
        private func deleteMeal(at offsets: IndexSet) {
            for index in offsets {
                    if let mealId = meals[index].id {
                        MealDataManager.deleteMealData(userId: userId, mealId: mealId) { success in
                            if success {
                                meals.remove(at: index)
                            }
                        }
                    }
                }
            }
        
    }


//#Preview {
  //  MealSectionView()
//}
