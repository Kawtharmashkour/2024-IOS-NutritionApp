//
//  AuthViewModel.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-18.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var userId: String? //Behnaz
   
    
    //if the user is sign in store data locally in the device
    init(){
        self.userSession = Auth.auth().currentUser
        self.userId = userSession?.uid //Behnaz
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            // Check for cached credentials and sign out if necessary
            if let currentUser = Auth.auth().currentUser {
                try Auth.auth().signOut()
                   }
            let result = try await Auth.auth().signIn(withEmail : email, password: password)
            self.userSession = result.user
            self.userId = result.user.uid
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String,
                    height: String, weight: String, targetWeight: String, gender : String, age: String , activityLevel: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
         

            let user = User(id: result.user.uid, fullname: fullname, email: email, height: height, weight: weight, targetWeight: targetWeight, gender: gender, age: age, activityLevel: activityLevel)
            //Encode data
            let encodedUser = try Firestore.Encoder().encode(user)
            //upload data to firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print("DEBUG: Failed to creat user with error \(error.localizedDescription)")
        }
    }
    
    
    func signOut() {
        do{
            try Auth.auth().signOut() //Sign out user on backend
            self.userSession = nil // Wipes out user session and and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
            self.userId = nil //Behnaz
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
        
    }
    
    func fetchUser() async {
        do {
            // Get current user ID
            guard let uid = Auth.auth().currentUser?.uid else {
                print("Error: User ID not available.")
                return
            }
            
            // Fetch user document from Firestore
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            // Check if document exists
            guard let data = documentSnapshot.data() else {
                print("Error: User document not found.")
                return
            }
            
            // Decode user data into User object
            if let user = try? documentSnapshot.data(as: User.self) {
                self.currentUser = user
            } else {
                print("Error: Failed to decode user data.")
            }
        } catch {
            // Handle any errors
            print("Error fetching user: \(error.localizedDescription)")
        }
    }

    func editFetchUser() async -> User? {
        do {
            // Get current user ID
            guard let uid = Auth.auth().currentUser?.uid else {
                print("Error: User ID not available.")
                return nil
            }
            
            // Fetch user document from Firestore
            let documentSnapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            // Check if document exists
            guard let data = documentSnapshot.data() else {
                print("Error: User document not found.")
                return nil
            }
            
            // Decode user data into User object
            if let user = try? documentSnapshot.data(as: User.self) {
                return user
            } else {
                print("Error: Failed to decode user data.")
                return nil
            }
        } catch {
            // Handle any errors
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }

    func updateProfile(fullname: String, email: String, height: String, weight: String, targetWeight: String, gender: String, age: String, activityLevel: String) async {
        let db = Firestore.firestore()
        
        // Get current user ID
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: User ID not available.")
            return
        }
        
        let userRef = db.collection("users").document(uid)
        
        // Prepare the data to update
        let data: [String: Any] = [
            "fullname": fullname,
            "email": email,
            "height": height,
            "weight": weight,
            "targetWeight": targetWeight,
            "gender": gender,
            "age": age,
            "activityLevel": activityLevel
        ]
        
        do {
            // Update the user profile data in Firestore
            try await userRef.setData(data, merge: true)
            print("User profile updated successfully.")
        } catch {
            print("Error updating user profile: \(error.localizedDescription)")
        }
    }
    
    
}
