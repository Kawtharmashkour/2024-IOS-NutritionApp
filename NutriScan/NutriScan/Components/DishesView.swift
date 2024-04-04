//
//  DishesView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct DishesView: View {
    var body: some View {
        HStack {
            //Left side
            NavigationStack{
                VStack(alignment: .leading, spacing: 4){
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.GeneralSearchRecipe(text: "Toast"))) {
                        HStack {
                            Image("icon-toasts")
                                .resizable()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Toasts")
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.GeneralSearchRecipe(text: "Tacos"))) {
                        HStack {
                            Image("icon-tacos")
                                .resizable()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Tacos")
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.searchRecipeDishTypeURL(dishType: "salad"))) {
                        HStack {
                            Image("icon-salads")
                                .resizable()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Salads")
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.GeneralSearchRecipe(text: "Spread"))) {
                        HStack {
                            Image("icon-halfavo")
                                .resizable()
                                .modifier(IconModifier())
                            Spacer()
                            Text("Spreads")
                        }
                    }
                }
            }
        // heart center
            VStack {
                HStack {
                    Divider()
                }
                
                Image(systemName: "heart.circle")
                    // to change system image size
                    .font(Font.title.weight(.ultraLight))
                    .imageScale(.large)
                HStack {
                    Divider()
                }
            }
            // Right side
                    VStack{
                        NavigationStack {
                            NavigationLink(destination: RecipesListView(url: Constants.Urls.searchRecipeURL)) {
                        HStack {
                            Text("Meals")
                            Spacer()
                            Image("icon-guacamole")
                                .resizable()
                                .modifier(IconModifier())
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.searchRecipeDishTypeURL(dishType: "sandwiches"))) {
                        HStack {
                            Text("Sandwitch")
                            Spacer()
                            Image("icon-sandwiches")
                                .resizable()
                                .modifier(IconModifier())
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.searchRecipeDishTypeURL(dishType: "soup"))) {
                        HStack {
                            Text("Soup")
                            Spacer()
                            Image("icon-soup")
                                .resizable()
                                .modifier(IconModifier())
                        }
                    }
                    Divider()
                    NavigationLink(destination: RecipesListView(url: Constants.Urls.GeneralSearchRecipe(text: "smoothie"))) {
                        HStack {
                            Text("Smoothie")
                            Spacer()
                            Image("icon-smoothies")
                                .resizable()
                                .modifier(IconModifier())
                        }
                    }
                }
            }
            
        }
        .font(.system(.callout, design: .serif))
        .foregroundColor(.gray)
        .padding(.horizontal)
        .frame(maxHeight: 220)
    }
    
}

#Preview {
    DishesView()
}
