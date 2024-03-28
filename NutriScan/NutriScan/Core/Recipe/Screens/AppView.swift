//
//  AppView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
       
            VStack (alignment: .leading)  {
                if let fullname = viewModel.currentUser?.fullname {
                    Text("Welcome, \(fullname)")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ColorGreenAdaptive"))
                        .padding(.trailing, 5)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
            }
            
            
            
            TabView {
                HomeView()
                    .tabItem({
                        Image(systemName: "house.fill")
                        Text("Home")
                    })
                
                //RecipesListView(url: Constants.Urls.searchRecipeURL) okok
                RecipesListView(url: Constants.Urls.searchRecipeMealTypeURL(mealType: "Breakfast"))
                    .tabItem ({
                        Image(systemName: "book.pages.fill")
                        Text("Recipes")
                    })
                NutritionView()
                    .tabItem {
                        Image("tabicon-meals")
                            .renderingMode(.template) // Set rendering mode to template
                        Text("My Meals")
                    }
            Spacer()
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
