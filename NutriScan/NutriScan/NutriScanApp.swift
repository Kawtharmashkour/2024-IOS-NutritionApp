//
//  NutriScanApp.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-15.
//

import SwiftUI
import SwiftData


@main
struct NutriScanApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginView()
                .environmentObject(viewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
