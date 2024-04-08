//
//  ImageView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct ImageCardView: View {
    let recipe: RecipeViewModel
    var body: some View {
        VStack{
            AsyncImage(url: recipe.image) { image in
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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}



