//
//  MealSectionView.swift
//  Callories
//
//  Created by behnaz Khalili on 2024-03-18.
//

import SwiftUI

struct MealSectionView: View {
    var mealType: String
    var goalCalories: Double
    var items: [MealItem]
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(mealType) Goal: \(goalCalories, specifier: "%.0f") calories")
                .font(.headline)
            ForEach(items) { item in
                MealItemView(mealItem: item)
            }
            Button(action: {
                // Action to add a new meal item
            }) {
                Image(systemName: "plus.circle.fill")
                Text("Add Item")
            }
        }
        .padding()
    }
}
//#Preview {
 //   MealSectionView()
//}
