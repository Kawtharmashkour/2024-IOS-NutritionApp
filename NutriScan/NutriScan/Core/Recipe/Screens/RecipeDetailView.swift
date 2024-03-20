//
//  RecipeDetailView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @State private var pullstate: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center, spacing: 0) {
                ImageCardView(recipe: recipe)
                
              Group{
                    //Title
                    Text(recipe.recipe.label)
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top,10)
                        .foregroundColor(Color("ColorGreenAdaptive"))
                    //Rating
                     RecipeRatingView(recipe: recipe)
                    //Ingredient
                    Text("Ingredients")
                        .fontWeight(.bold)
                        .font(.system(.largeTitle, design: .serif))
                        .foregroundColor(Color("ColorGreenAdaptive"))
                    
                    VStack (alignment: .leading, spacing: 5) {
                        ForEach(recipe.recipe.ingredientLines, id:\.self) { item in
                            VStack (alignment: .leading, spacing: 5){
                                HStack {
                                    Text(item)
                                        .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                    
                }
                .padding(.horizontal,24)
                .padding(.vertical, 12)
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .overlay(
            
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                       // withAnimation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            Image(systemName: "chevron.down.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                                .opacity(self.pullstate ? 1 : 0.6)
                                .scaleEffect(self.pullstate ? 1.2 : 0.8, anchor: .center)
                        //}
                            
                })
                    .padding(.trailing,20)
                    .padding(.top,24)

                    Spacer()
                }
                
            }
        )
        .onAppear() {
            self.pullstate.toggle()
        }
    }
}

/*#Preview {
    RecipeDetailView(recipe: Recipe.recipesList[0])
}*/

