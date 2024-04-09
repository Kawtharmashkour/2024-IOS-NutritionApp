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
    @State private var showActionSheet = false
    @State private var showAlert = false
    //@State var mealType: String = ""
    @AppStorage("navMealType") var navMealType: String = ""
    
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
                  //  RecipeRatingView(recipe: recipe)
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
            HStack (alignment: .center) {
                NutritionFact(text: "Calories", number: recipe.totalNutrients.ENERC_KCAL.quantity)
                NutritionFact(text: "Fats", number: recipe.totalNutrients.FAT.quantity)
                NutritionFact(text: "Carbs", number: recipe.totalNutrients.CHOCDF.quantity)
                NutritionFact(text: "Protein", number: recipe.totalNutrients.PROCNT.quantity)
                
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding()
            
            // Add meal button
            HStack{
                
                Spacer()
                Button(action: {
                    print("Buton pressed ,navMealType = ")
                    
                    if(navMealType == "") {
                        showActionSheet = true
                    }else {
                        MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealData: self.recipe, mealType: navMealType)
                        navMealType = ""
                        showAlert = true
                    }
                },label:  {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("ColorGreenAdaptive"))
                })
                .actionSheet(isPresented: $showActionSheet) {
                    
                        ActionSheet(title: Text("Choose Meal destination"),
                                    message: Text(""),
                                    buttons: [
                                        .cancel(),
                                        .default(
                                            Text("Breakfast"),
                                            action: {
                                                MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealData: self.recipe, mealType: "breakfast")
                                                showAlert = true
                                            }
                                        ),
                                        .default(
                                            Text("Lunch"),
                                            action: {
                                                MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealData: self.recipe, mealType: "lunch")
                                                showAlert = true
                                            }
                                        ),
                                        .default(
                                            Text("Diner"),
                                            action: {
                                                MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealData: self.recipe, mealType: "diner")
                                                showAlert = true
                                            }
                                        )
                                        ,
                                        .default(
                                            Text("Snack"),
                                            action: {
                                                MealDataManager.insertMealData(userId: authViewModel.userId ?? "", mealData: self.recipe, mealType: "snack")
                                                showAlert = true
                                            }
                                        )
                                    ]
                        )
                    }
            }
            .padding(.horizontal,20)
            .padding(.bottom,24)
        }
        .background(Color("ColorAppearanceAdaptive"))
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x:0, y:0)
        .alert(isPresented: $showAlert) {
                    Alert(title: Text("Confirmation"), message: Text("Meal added successfully"), dismissButton: .default(Text("OK")))
                }
    }
    
    
}

/*#Preview {
    RecipeCardView(recipe: )
        .previewLayout(.sizeThatFits)
}
*/
