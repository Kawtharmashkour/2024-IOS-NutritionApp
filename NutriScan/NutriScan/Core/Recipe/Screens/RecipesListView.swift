//
//  RecipesListView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipesListView: View {
    let url: URL
    @StateObject private var recipeListVM = RecipeListViewModel() //class name
    @State private var isLoading = false
    @State private var searchText = ""
    @State private var filteredRecipes: [RecipeViewModel] = []
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...").tint(Color("ColorAppearanceAdaptive"))
            } else {
                //SearchBar()
                NavigationView {
                    List(filteredRecipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .listRowSeparator(.hidden, edges: .all)
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: 640)
                    .searchable(text: $searchText)
                    
                }
            }
        }
        .onAppear {
            fetchData()
        }
        .onChange(of: searchText) {
                    filterRecipes()
                }
    }
    
    func fetchData() {
        isLoading = true
        Task {
            do {
                //recipes = try await getUser()
                await recipeListVM.populateRecipeList(url: url)
                filteredRecipes = recipeListVM.recipeList
                
            } catch {
                print("Error fetching data: \(error)")
            }
            isLoading = false
        }
    }
    
    func filterRecipes() {
            if searchText.isEmpty {
                filteredRecipes = recipeListVM.recipeList
            } else {
                filteredRecipes = recipeListVM.recipeList.filter { recipe in
                   recipe.title.localizedCaseInsensitiveContains(searchText) ||
                   recipe.ingredients.contains { ingredient in
                                    ingredient.food.localizedCaseInsensitiveContains(searchText)
                                }
                    }
            }
        //print("Reachable")
        }

}

/*#Preview {
    RecipesListView()
}*/


enum GHError: Error {
    case invalidURL
    case invalidResponse
}
