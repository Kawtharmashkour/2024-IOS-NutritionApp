//
//  RecipesListView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-19.
//

import SwiftUI

struct RecipesListView: View {
    var url: URL
    @StateObject var recipeListVM = RecipeListViewModel() //class name
    @State private var isLoading = false
    @State private var searchText = ""
    @State private var filteredRecipes: [RecipeViewModel] = []
    @State private var isMenuVisible1 = false
    @AppStorage("selectedFilters") var selectedFilters: String = ""
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView().tint(Color("ColorAppearanceAdaptive"))
            } else {
                ZStack{
                    if isMenuVisible1 {
                        FilterMenuView(isMenuVisible1: $isMenuVisible1, doneAction: {filters in
                            print(filters)
                            let apiUrl = "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac\(filters)"
                            
                            guard let url = URL(string: apiUrl) else {
                                print("Invalid URL")
                                return
                            }

                            fetchData(url: url)
                        })
                            .zIndex(1)
                    }
                    NavigationStack {
                        
                        SearchBar(searchText: $searchText)
                        
                        List {
                            HStack {
                                Text("Result: \(recipeListVM.to) of \(recipeListVM.count) Recipes")
                                Spacer()
                                //Filtering
                                Button(action: {
                                    isMenuVisible1.toggle()
                                }) {
                                    Image("icon-filter")
                                        .resizable()
                                        .modifier(IconModifier())
                                }
                                
                            }
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
                    .navigationBarTitleDisplayMode(.inline)
                    //.padding(.top, 20)
                }
            }
        }
        .onAppear {
            isLoading = true
            fetchData(url: url)
           selectedFilters = ""
            isLoading = false
        }
        .onChange(of: searchText) {
                    filterSearchRecipes()
                }
    }
    
    func fetchData(url: URL) {
        Task {
                await recipeListVM.populateRecipeList(url: url)
                filteredRecipes = recipeListVM.recipeList
        }
    }
    
    func filterSearchRecipes() {
            if searchText.isEmpty {
                filteredRecipes = recipeListVM.recipeList
            } else {
                
                    fetchData(url:Constants.Urls.GeneralSearchRecipe(text: searchText))
            }
        }
    
    func loadNextPage() {
            guard let nextPageUrl = recipeListVM.nextPageInfo?.href else { return }
            Task {
                    //fetchData(url:URL(string: nextPageUrl)!)
                await recipeListVM.populateRecipeList(url: URL(string: nextPageUrl)!)
                filteredRecipes = recipeListVM.recipeList
            }
        }
    
    // Function to filter recipes based on selected allergies
      /*  private func filteringRecipes() {
           //let allergiesQuery = selectedAllergies.joined(separator: ",")
            print(selectedAllergies[0])
            let apiUrl = "https://api.edamam.com/api/recipes/v2?type=public&app_id=b6bfd343&app_key=9f8b9dde8d42741c7dd5f9dbfeb447ac&health=\(selectedAllergies[0])"
            
            guard let url = URL(string: apiUrl) else {
                print("Invalid URL")
                return
            }

            fetchData(url: url)
        }*/

}

