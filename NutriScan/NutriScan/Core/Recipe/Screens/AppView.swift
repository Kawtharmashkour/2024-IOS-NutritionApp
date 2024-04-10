//
//  AppView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct AppView: View {
    var gmail :String?
    @State private var isOverlayVisible = false
    
    var body: some View {
            
            TabView {
                HomeView()
                    .tag(1)
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
                Button("Present!") {
                    isOverlayVisible.toggle()
                }
                               .tabItem {
                                   Image("tabicon-menu")
                                       .renderingMode(.template) // Set rendering mode to template
                                   Text("Menu")
                               }
                               .onAppear{
                                isOverlayVisible = true
                               }
            }
            .accentColor(Color("ColorGreenAdaptive"))
            .overlay(
                          Group {
                              if isOverlayVisible {
                                  SlideOutMenu(isOverlayVisible: $isOverlayVisible)
                                      .background(Color("ColorBlackTransparentLight"))
                              }
                          }
                      )
            
        }
    }
    

