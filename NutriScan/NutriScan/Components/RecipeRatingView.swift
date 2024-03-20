//
//  RecipeRatingView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipeRatingView: View {
    var recipe: Recipe
    
    var body: some View {
        
        HStack (alignment: .center, spacing: 5) {
            ForEach(1...5/*(recipe.rating)*/, id:\.self) { _ in
                Image(systemName: "star.fill")
                    .font(.body)
                    .foregroundColor(.yellow)
            }
        }
    }
}

/*#Preview {
    RecipeRatingView(recipe: Recipe.recipesList[0])
}
*/
