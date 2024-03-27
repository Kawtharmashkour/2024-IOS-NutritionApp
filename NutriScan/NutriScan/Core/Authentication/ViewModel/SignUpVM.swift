//
//  SignUpVM.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-25.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var isLogin: Bool = false
    

    private let firebaseAuth = Auth.auth()

    
    func signUpWithGoogle() {
        // Get app client id
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Get configuration
        
        
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()) { result, error in
            
            // Sign in
            
            GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {result,  error in
                
                
                if let error = error {
                    print(" Google Sign In Error: \(error.localizedDescription)")
                    return
                }
                
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString
                else { return }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { result, error in
                    
                    
                    if let err = error {
                        
                        print("Firebase Auth Error: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    guard let user = result?.user else { return }
                    
                    print(user.displayName as Any)
                    print(user.displayName)
                    
                    self.isLogin.toggle()
                }
            }
        }
        
        
        
    }
    func signOutFromGoogle(){
        
        do {
            try firebaseAuth.signOut()
            print("Customer signed out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

