//
//  Food.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-21.
//

import Foundation
import UIKit

class FoodItem {
    var name: String
    var calories: Int
    var protein: Int
    var carbs: Int
    var fats: Int
    
    init(name: String, calories: Int, protein: Int, carbs: Int, fats: Int) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
    }
}
