//
//  SearchBar.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        
        TextField("Search diet, meal type, ingredient", text: $searchText)
            .padding()
            .frame( height: 50) // Adjust size as needed
            .background(Color("ColorAppearanceAdaptive"))
            .cornerRadius(15) // Add corner radius for rounded corners
            .shadow(color: Color("ColorBlackTransparentLight"), radius: 2, x: 0, y: 2) // Add shadow
            .padding(.horizontal)
            .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("ColorGreenAdaptive")) // Set the color of the icon
                            .padding(.leading, 30) // Adjust padding as needed
                        Spacer()
                    }
            )
    }
}

/*#Preview {
    SearchBar()
}*/
