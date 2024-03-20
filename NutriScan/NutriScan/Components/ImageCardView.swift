//
//  ImageView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct ImageCardView: View {
    let recipe: Recipe
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: recipe.recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        BookMarkView()
                    )
                    
            } placeholder: {
                Rectangle()
                    .foregroundColor(.secondary)
            }
        }
        //.padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

/*#Preview {
    
    ImageCardView(recipe: recipe )
}
    
let recipe = Recipe(recipe: RItem(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_04a0fb734d8ccc244b8a10758df03824", label: "Pan de Sal - Filipino Bread Rolls", image: "https://edamam-product-images.s3.amazonaws.com/web-img/faa/faa4b3c7b73246b1618e337c4c5feb9e.jpg"))
*/
