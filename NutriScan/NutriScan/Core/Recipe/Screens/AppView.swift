//
//  AppView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem({
                    Image(systemName: "house.fill")
                    Text("Home")
            })
            
            RecipesListView()
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
