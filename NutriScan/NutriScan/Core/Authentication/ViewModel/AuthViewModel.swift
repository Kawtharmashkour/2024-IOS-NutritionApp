//
//  AuthViewModel.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-18.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail eamil: String, password: String, fullname: String, weight: String,
                    height: String, targetWeight: String, gender : String) async throws {
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
    
}
