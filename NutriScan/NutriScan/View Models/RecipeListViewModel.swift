//
//  RecipeListViewModel.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-22.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    
    @Published var recipeList: [RecipeListViewModel] = []
    
    func populateRecipeList() async {
        
        do {
            let recipeListResponse = try await WebService().get(url: Constants.Urls.searchRecipeURL) { data in
                    //parsing data: this is the implementation of parse closure
                
                    //try?: If decoding succeeds, the result will be an optional containing the decoded value. If decoding fails (due to an error being thrown), the result will be nil. because in Webservice if result of parse is nil will thrown an error
                    return try? JSONDecoder().decode(RecipeListResponse.self, from: data)
                    }
           // self.recipeList = recipeListResponse.hits.map(RecipeViewModel.init)
            
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
}



