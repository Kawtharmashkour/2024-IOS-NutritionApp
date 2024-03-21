//
//  MealItemView.swift
//  Callories
//
//  Created by behnaz Khalili on 2024-03-18.
//

import SwiftUI

struct MealItemView: View {
    var mealItem: MealItem
    var body: some View {
        HStack {
                    Text(mealItem.name)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(mealItem.calories, specifier: "%.2f") cal")
                        HStack {
                            Text("\(mealItem.protein, specifier: "%.2f")g")
                            Text("\(mealItem.carbs, specifier: "%.2f")g")
                            Text("\(mealItem.fat, specifier: "%.2f")g")
                        }
                    }
                }
            }
        }

