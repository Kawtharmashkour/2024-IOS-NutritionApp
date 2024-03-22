//
//  RecipesListView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipesListView: View {
    //for test puposes
    //var recipes: [Recipe] //= Recipe.recipesList
    /*@State private var recipes: [Recipe?]
    
    var body: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            
            ForEach(recipes, id:\.self) { item in
                    RecipeCardView(recipe: item)
                }
                
            
        }
        .frame(maxWidth: 640)
        .listStyle(.grouped)
        //.padding(.horizontal)
    }*/
    @State private var recipes: [Recipe] = []
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
            } else {
                List(recipes, id: \.recipe.uri) { recipe in
                    RecipeCardView(recipe: recipe)
                }
                .listStyle(.grouped)
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
                recipes = try await getUser()
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

#Preview {
    RecipesListView()
}

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
