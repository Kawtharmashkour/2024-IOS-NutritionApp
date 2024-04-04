//
//  NutriScanApp.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-15.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SwiftData



@main
struct NutriScanApp: App {
    @StateObject var viewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
   
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
           //RecipesListView()
           //ContentView()
           LoginView()
//               .environmentObject(viewModel)
            
//            SocialMediaSignUpView()
                        .environmentObject(viewModel) // Attach AuthViewModel instance
                        .environmentObject(SignUpViewModel()) 

        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
       }
    
}
