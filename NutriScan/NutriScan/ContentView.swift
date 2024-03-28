//
//  ContentView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: AuthViewModel
    @Query private var items: [Item]
    @State private var isLoggedIn = false

    var body: some View {
            
        if isLoggedIn {
                 AppView()
                     .navigationBarHidden(true) // Hide navigation bar for AppView
             } else {
                 SocialMediaSignUpView()
                     .navigationBarHidden(true) // Hide navigation bar for SocialMediaSignUpView
             }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
