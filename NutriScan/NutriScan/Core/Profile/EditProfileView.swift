//
//  EditProfileView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-26.
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var user: User?
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var fullnameError = ""
    @State private var weight = ""
    @State private var weightError = ""
    @State private var targetWeight = ""
    @State private var targetWeightError = ""
    @State private var height = ""
    @State private var heightError = ""
    @State private var selectedGender: String? = ""
    let genders = ["Male", "Female"]
    
    @State private var hasChanges = false // Flag to track changes
    @State private var showAlert = false  // Flag to control showing the alert
    @Environment(\.presentationMode) var presentationMode // Access presentationMode

    var body: some View {
        
        
        var formIsValid: Bool {
            return  fullnameError.isEmpty && heightError.isEmpty && weightError.isEmpty && targetWeightError.isEmpty
        }
        
        VStack(alignment: .leading, spacing: 8) {
            
            EditInputview(text: $email, title: "Email Address")
                .disabled(true)
                .opacity(0.5)
            
            EditInputview(text: $fullname, title: "Full Name")
            Text(fullnameError)
                .foregroundColor(.red)
                .padding(.leading)
            

            
            EditInputview(text: $height , title: "Height")
                .keyboardType(.decimalPad)
                 Text(heightError)
                .foregroundColor(.red)
                .padding(.leading)
            
            EditInputview(text: $weight, title: "Weight")
                .keyboardType(.decimalPad)
                 Text(weightError)
                .foregroundColor(.red)
                .padding(.leading)
            
            EditInputview(text: $targetWeight, title: "Target Weight")
                .keyboardType(.decimalPad)
                 Text(targetWeightError)
                .foregroundColor(.red)
                .padding(.leading)
            
            Text("Gender")
                .font(.subheadline)
                .foregroundColor(.black)
            
            HStack{
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        self.selectedGender = gender
                    }) {
                        HStack {
                            if self.selectedGender == gender {
                                Image(systemName: "largecircle.fill.circle").foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                            }
                            Text(gender)
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
            }
        }//VStack
    
    .padding(.horizontal)
    .padding(.top, 3)
        
        
    
    Button {
        Task{
            guard let gender = selectedGender else {
                return
            }
            try await viewModel.updateProfile(fullname: fullname, email: email, height: height, weight: weight, targetWeight: targetWeight, gender: gender)
            
            await viewModel.fetchUser()
            showAlert = true
          
        }
    } label: {
        HStack{
            Text("Update")
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
    }
    .background(Color(.systemGreen))
  .disabled(!formIsValid || !hasChanges)
  .opacity (formIsValid && hasChanges ? 1 : 0.5)
    .cornerRadius(10)
    .padding(.bottom, 10)
    .padding(.top, 10)
    .alert(isPresented: $showAlert){
        Alert(
            
            title: Text("Success"),
            message : Text ("Profile updated successfully."),
            primaryButton: .default(Text("OK") , action: {
                // Dismiss the current view and navigate back to the profile view
                presentationMode.wrappedValue.dismiss()
            }),
            
            secondaryButton: .cancel()
        
        )
    }
    
        
    .onChange(of: [email, fullname, height, weight, targetWeight]) { _ in
        fullnameError = Validation.validateFullName(fullname)
        heightError = Validation.validateHeight(height)
        weightError = Validation.validateWeight(weight)
        targetWeightError = Validation.validateWeight(targetWeight)
        
        hasChanges = true
    }
        
        
        
    .onAppear {
        Task {
                // Fetch user data
                if let editFetchedUser = await viewModel.editFetchUser()  {
                    
                    // Update state variables with fetched user data
                    user = editFetchedUser
                    fullname = editFetchedUser.fullname
                    email = editFetchedUser.email
                    height = editFetchedUser.height
                    weight = editFetchedUser.weight
                    targetWeight = editFetchedUser.targetWeight
                    selectedGender = editFetchedUser.gender
                    
                    hasChanges = false
                } else {
                    // Handle any errors that occur during fetching
                    // handle(error: error)
                }
            }
        }
        

        .navigationTitle("Edit Profile")
    } //Some view

}// struct

