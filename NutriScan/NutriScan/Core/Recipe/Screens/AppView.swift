//
//  AppView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct AppView: View {

    var body: some View {
       /* VStack (alignment: .leading)  {
            if let fullname = viewModel.currentUser?.fullname {
                Text("Welcome, \(fullname)")
                    .font(.system(size: 14))
                    .foregroundColor(Color("ColorGreenAdaptive"))
                    .padding(.trailing, 5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
        }*/


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
        //.background(Color.yellow)
        .accentColor(Color.primary)
            
    }
}

#Preview {
    AppView()
}
