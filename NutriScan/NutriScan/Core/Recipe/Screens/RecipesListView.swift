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
                ProgressView("Loading...")
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
 /*   func getUser() async throws -> [Recipe] {
        //let app_id = "b6bfd343"
       // let app_key = "9f8b9dde8d42741c7dd5f9dbfeb447ac"
        let endpoint = "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&cuisineType=Asian&mealType=Breakfast&dishType=Bread"
        
        guard let url = URL(string: endpoint) else { throw GHError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Print the raw response data before decoding
        /* print("Response Data Before Decoding:")
            if let responseDataString = String(data: data, encoding: .utf8) {
                print(responseDataString)
            }*/
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        let decodedRecipe = try JSONDecoder().decode(RecipeListResponse.self, from: data)
        print(decodedRecipe)
        return decodedRecipe.hits.map { $0 }
        
    }*/
    
}

/*#Preview {
    RecipesListView()
}*/


enum GHError: Error {
    case invalidURL
    case invalidResponse
}
