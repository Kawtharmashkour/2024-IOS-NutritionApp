//
//  RecipeCardView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipeCardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var recipe: RecipeViewModel
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModel: Bool = false
    @State private var selectedMealType: String?
    @State private var showMealTypeSelection: Bool = false
    
    var body: some View {
        // Image card
        VStack{
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
                    
                    //Rates
                    RecipeRatingView(recipe: recipe)
                }
                .padding()
                
            }
            .background(Color("ColorAppearanceAdaptive"))
            .onTapGesture {
                self.hapticImpact.impactOccurred()
                self.showModel = true
            }
            .sheet(isPresented: self.$showModel){
                RecipeDetailView(recipe: self.recipe)
            }
            //Nutrition facts
            HStack{
                HStack (alignment: .center, spacing: 12) {
                    Text("Calories\(GeneralFunc.Number2DigitsAfterpoint(number: recipe.totalNutrients.ENERC_KCAL.quantity)), fat\(GeneralFunc.Number2DigitsAfterpoint(number: recipe.totalNutrients.FAT.quantity)), carbs\(GeneralFunc.Number2DigitsAfterpoint(number: recipe.totalNutrients.CHOCDF.quantity)), protien\(GeneralFunc.Number2DigitsAfterpoint(number: recipe.totalNutrients.PROCNT.quantity))")
                    
                }
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.leading,20)
                
                Spacer()
                Button(action: {
                    print("Buton pressed")
                    //handel meal type?????
                    MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealType: "breakfast", mealData: self.recipe)
                },label:  {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("ColorGreenAdaptive"))
                })
            }
            .padding(.horizontal,20)
            .padding(.bottom,24)
        }
        .background(Color("ColorAppearanceAdaptive"))
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x:0, y:0)
        .padding()
    }
    
    //Functions
    /*private var mealTypeButtons: [Alert.Button] {
     recipe.mealType.compactMap { mealType in
     Alert.Button.default(Text(mealType)) {
     selectedMealType = mealType
     // Call the function to update the recipes based on the selected meal type
     // fetchRecipesByMealType(mealType: mealType)
     print("\(String(describing: selectedMealType))")
     }
     }*/
    
}

/*#Preview {
    RecipeCardView(recipe: )
        .previewLayout(.sizeThatFits)
}
*/
