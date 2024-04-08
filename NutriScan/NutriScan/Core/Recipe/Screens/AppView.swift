//
//  AppView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct AppView: View {
    var gmail :String?
    
    var body: some View {
       
        TabView {
            HomeView()
                .tabItem({
                    Image(systemName: "house.fill")
                    Text("Home")
            })
            
            RecipesListView(url: Constants.Urls.searchRecipeURL)
           //RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "Breakfast"))
                .tabItem ({
                    Image(systemName: "book.pages.fill")
                    Text("Recipes")
                })
            NutritionView()
                .tabItem {
                    Image("icon-mealplanner")
                        .renderingMode(.template) // Set rendering mode to template
                    Text("Meals Plan")
                }
            SlideOutMenu()
                .tabItem {
                    Image("tabicon-menu")
                        .renderingMode(.template) // Set rendering mode to template
                    Text("Menu")
                }
        }
        .accentColor(Color("ColorGreenAdaptive"))
            
    }
}


