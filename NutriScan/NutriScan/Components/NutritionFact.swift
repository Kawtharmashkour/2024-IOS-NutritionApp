//
//  NutritionFact.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-28.
//

import SwiftUI

struct NutritionFact: View {
    var text: String
    var number: Double
    private var color: Color {
        switch text {
        case "Protein":
            return .green
        case "Carbs":
            return  .yellow
        case "Fats":
            return  .purple
        case "Calories":
            return .orange
        default:
            return .blue
        }
    }
    var body: some View {

        HStack {
            
                ProgressView(value: 0.6)
                    .tint(color)
                    .rotationEffect(Angle(degrees: 270))
                    .frame(width: 30, height: 40)
                    .padding(.trailing, -15)
            
            VStack(alignment: .leading){
                Text("\(number, specifier: "%.2f") g")
                    .fontWeight(.bold)
                Text(text)
            }
            .font(.footnote)
        }
    }
}

#Preview {
    NutritionFact(text: "Carbs", number: 12.23)
}
