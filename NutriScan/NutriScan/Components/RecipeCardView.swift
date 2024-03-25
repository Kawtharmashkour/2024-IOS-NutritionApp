//
//  RecipeCardView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipeCardView: View {
    var recipe: RecipeViewModel
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModel: Bool = false
    
    var body: some View {
        // Image card
        VStack {
            ImageCardView(recipe: recipe)
        
            VStack (alignment: .leading, spacing: 12) {
                //Title
                Text(recipe.title)
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenAdaptive"))
                    .lineLimit(1)
                
                //Ingredients
                Text(recipe.ingredients.map { $0.food }.joined(separator: ", "))
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
               
                
               /* Text(recipe.headline)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.gray)
                    .italic()*/
                
                //Rates
               // RecipeRatingView(recipe: recipe)
                
                //Nutrition facts
                HStack (alignment: .center, spacing: 12) {
                    Text("Calories\(recipe.calories)")
                    
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
        }
        .background(Color("ColorAppearanceAdaptive"))
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x:0, y:0)
        .onTapGesture {
            self.hapticImpact.impactOccurred()
            self.showModel = true
        }
        .sheet(isPresented: self.$showModel){
            RecipeDetailView(recipe: self.recipe)
        }
        .background(Color("ColorAppearanceAdaptive"))
    }
    
}

/*#Preview {
    RecipeCardView(recipe: )
        .previewLayout(.sizeThatFits)
}
*/
