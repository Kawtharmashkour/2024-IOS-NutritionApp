//
//  HomeView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            // Header
            HeaderView()
            
            // MARK: - DISHES
            
            Text("NutriScan Dishes")
                .fontWeight(.bold)
                .padding(30)
                .foregroundColor(Color("ColorGreenAdaptive"))

            //.modifier(TitleModifier())
            
            VStack {
                DishesView()
                    .frame(maxWidth: 640)
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
              
    }
}

#Preview {
    HomeView()
}
