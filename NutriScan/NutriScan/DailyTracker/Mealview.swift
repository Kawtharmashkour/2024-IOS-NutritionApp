//
//  Mealview.swift
//  NutriScan
//
//  Created by behnaz Khalili on 2024-03-22.
//

import SwiftUI

struct Mealview: View {
    @ObservedObject var model = ViewModel()
    var body: some View {
        List(model.list,id: \.self) { item in Text(item)
        }
    }
}

#Preview {
    Mealview()
}
