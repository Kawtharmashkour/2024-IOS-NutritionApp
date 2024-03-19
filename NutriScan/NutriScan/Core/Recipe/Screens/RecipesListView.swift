//
//  RecipesListView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipesListView: View {
    var recipes: [Recipe] //= Recipe.recipesList
    var body: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            
                ForEach(recipes) { item in
                    RecipeCardView(recipe: item)
                }
                
            
        }
        .frame(maxWidth: 640)
        .listStyle(.grouped)
        //.padding(.horizontal)
    }
}

#Preview {
    RecipesListView(recipes: Recipe.recipesList)
}
