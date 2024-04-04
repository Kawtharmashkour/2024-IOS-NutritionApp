//
//  RecipesListView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipesListView: View {
    var url: URL
    @StateObject private var recipeListVM = RecipeListViewModel() //class name
    @State private var isLoading = false
    @State private var searchText = ""
    @State private var filteredRecipes: [RecipeViewModel] = []
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...").tint(Color("ColorAppearanceAdaptive"))
            } else {
                
                NavigationStack {
                    
                  SearchBar(searchText: $searchText)
                    
                    List {
                        ForEach(filteredRecipes) { recipe in
                                RecipeCardView(recipe: recipe)
                                    .listRowSeparator(.hidden, edges: .all)
                         
                        }
                        // appears when the end list reached
                       ProgressView()
                            .frame(maxWidth: .infinity)
                            .onAppear {
                                loadNextPage()
                            }
                    }
                    .listStyle(.plain)
                    .frame(maxWidth: 640)
                    
                }
            }
        }
        .onAppear {
            fetchData(url: url)
        }
        .onChange(of: searchText) {
                    filterRecipes()
                }
    }
    
    func fetchData(url: URL) {
        isLoading = true
        Task {
            do {
                await recipeListVM.populateRecipeList(url: url)
                
                // Append the new recipes to the existing list
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
                Task{
                    do {
                        await recipeListVM.populateRecipeList(url: Constants.Urls.GeneralSearchRecipe(text: searchText))
                        filteredRecipes = recipeListVM.recipeList
                    } catch {
                        print("Error fetching next page: \(error)")
                    }
                }
                //fetchData(url: Constants.Urls.GeneralSearchRecipe(text: searchText))
                
                /*filteredRecipes = recipeListVM.recipeList.filter { recipe in
                   recipe.title.localizedCaseInsensitiveContains(searchText) ||
                   recipe.ingredients.contains { ingredient in
                                    ingredient.food.localizedCaseInsensitiveContains(searchText)
                                }
                    }*/
            }
        //print("Reachable")
        }
    
    func loadNextPage() {
            guard let nextPageUrl = recipeListVM.nextPageInfo?.href else { return }
            Task {
                do {
                    await recipeListVM.populateRecipeList(url: URL(string: nextPageUrl)!)
                    filteredRecipes += recipeListVM.recipeList
                } catch {
                    print("Error fetching next page: \(error)")
                }
            }
        }

}

/*#Preview {
    RecipesListView()
}*/


enum GHError: Error {
    case invalidURL
    case invalidResponse
}
