//
//  RecipeListViewModel.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-22.
//

import Foundation

//@MainActor: is the every func and properties will be automatically called on main thread
@MainActor
class RecipeListViewModel: ObservableObject {
    
    @Published var recipeList: [RecipeViewModel] = []
    
    func populateRecipeList(url: URL) async -> Void {
        
        do {
            let recipeListResponse = try await WebService().get(url: url) { data in
                    //parsing data: this is the implementation of parse closure
                
                    //try?: If decoding succeeds, the result will be an optional containing the decoded value. If decoding fails (due to an error being thrown), the result will be nil. because in Webservice if result of parse is nil will thrown an error
                    return try? JSONDecoder().decode(RecipeListResponse.self, from: data)
                    }
            
            // Map the recipes from RecipeListResponse to RecipeViewModel
            // as soon as using @Published we should use @MainActor : so the result of self.recipeList will be (on the main queue on the main thread). Note: @MainActor is instead of dispatch
            self.recipeList = recipeListResponse.hits.map(RecipeViewModel.init)
            
        } catch {
            print(error)
        }
    }
}

struct RecipeViewModel: Identifiable {
    let id = UUID()
    private let recipeVM: Recipe
    
    init(_ recipeVM: Recipe) {
        self.recipeVM = recipeVM
    }
    
    var title: String {
        recipeVM.recipe.label
    }
    
    var image: URL? {
        URL(string: recipeVM.recipe.image)
    }
    
    var ingredientLines: [String] {
        recipeVM.recipe.ingredientLines
    }
    
    var ingredients: [Ingredient] {
        recipeVM.recipe.ingredients
    }
    var totalNutrients: TotalNutrition {
        recipeVM.recipe.totalNutrients
    }
    
    var calories: Double {
        recipeVM.recipe.calories
    }
}



