//
//  RecipeListResponse.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-21.
//

import Foundation

struct RecipeListResponse: Codable {
    let hits: [Recipe]
}

struct Recipe: Codable {
    let recipe: RItem
}

struct RItem: Codable {
    let uri: String
    let label: String
    let image: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalNutrients: TotalNutrition
    let calories: Double
}

struct Ingredient: Codable, Hashable {
    let food: String
}

struct TotalNutrition: Codable {
    let ENERC_KCAL: TotalNutritionDetail //calories
    let FAT : TotalNutritionDetail      //fat
    let CHOCDF: TotalNutritionDetail    //carbs
    let PROCNT: TotalNutritionDetail    //protien
}

struct TotalNutritionDetail: Codable {
    let quantity: Double
}
