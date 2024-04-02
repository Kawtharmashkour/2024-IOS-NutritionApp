//
//  Constants.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-21.
//

//let app_id = "b6bfd343"
// let app_key = "9f8b9dde8d42741c7dd5f9dbfeb447ac"
//let endpoint = "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&cuisineType=Asian&mealType=Breakfast&dishType=Bread"

import Foundation

struct Constants {
    struct Urls {
    
        static let searchRecipeURL = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&diet=balanced")!
        
        //general search
        static func GeneralSearchRecipe(text: String) -> URL {
            return URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=" + text + "&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac" )!
        }
        
        static func searchRecipeDishTypeURL(dishType: String) -> URL {
            return URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&dishType=" + dishType)!
        }
        
        static func searchRecipeMealTypeURL(mealType: String) -> URL {
            return URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&mealType=" + mealType)!
        }
    }
}
