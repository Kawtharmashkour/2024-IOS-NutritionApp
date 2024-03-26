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
    //@State private var recipes: [RecipeViewModel]
    //@State private var recipes: [Recipe] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else {
                SearchBar()
                List(recipeListVM.recipeList) { recipe in
                    RecipeCardView(recipe: recipe)
                }
                .listStyle(.plain)
                .frame(maxWidth: 640)
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        isLoading = true
        Task {
            do {
                //recipes = try await getUser()
                await recipeListVM.populateRecipeList(url: url)
                
            } catch {
                print("Error fetching data: \(error)")
            }
            isLoading = false
        }
    }
    
    func getUser() async throws -> [Recipe] {
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
        
    }
    
}

/*#Preview {
    RecipesListView()
}*/

/*struct RecipeListResponse: Codable {
    let hits: [Recipe]
}

struct Recipe: Codable {
    let recipe: RItem
}

struct RItem: Codable {
    let uri: String
    let label: String
    let image: String
    let ingredientLines: [String]
    let calories: Double
}*/

enum GHError: Error {
    case invalidURL
    case invalidResponse
}
