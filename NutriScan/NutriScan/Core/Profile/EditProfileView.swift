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
    @State private var emailError = ""
    @State private var fullname = ""
    @State private var fullnameError = ""
    @State private var password = ""
    @State private var passwordError = ""
    @State private var confirmPassword = ""
    @State private var confirmPasswordError = ""
    @State private var weight = ""
    @State private var weightError = ""
    @State private var targetWeight = ""
    @State private var targetWeightError = ""
    @State private var height = ""
    @State private var heightError = ""
    @State private var selectedGender: String? = ""
    let genders = ["Male", "Female"]
    
    @State private var hasChanges = false // Flag to track changes

    var body: some View {
        
        
        var formIsValid: Bool {
            return emailError.isEmpty && fullnameError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty && heightError.isEmpty && weightError.isEmpty && targetWeightError.isEmpty
        }
        
        VStack(alignment: .leading, spacing: 10) {
            
            EditInputview(text: $fullname, title: "Full Name")
            Text(fullnameError)
                .foregroundColor(.red)
                .padding(.leading)
            
            EditInputview(text: $email, title: "Email Address")
             Text(emailError)
                .foregroundColor(.red)
                .padding(.leading)
            
            EditInputview(text: $password, title: "Password", isSecureField: true)
            Text(passwordError)
                .foregroundColor(.red)
                .padding(.leading)
            
            ZStack(alignment: .trailing){
                EditInputview(text: $confirmPassword, title: "Confirm Password", isSecureField: true)
                
                if !password.isEmpty && !confirmPassword.isEmpty {
                    if password == confirmPassword {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemRed))
                    }
                }
            } //ZStack
           Text(confirmPasswordError)
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
    

//
//            Section {
//                Button("Save Changes") {
//                    // Call a function to save changes
//                    saveChanges()
//                }
//            }
//        }
        
    .onChange(of: [email, fullname, password, confirmPassword, height, weight, targetWeight]) { _ in
        emailError = Validation.validateEmail(email)
        fullnameError = Validation.validateFullName(fullname)
        passwordError = Validation.validateEditPassword(password)
        confirmPasswordError = Validation.validateEditConfirmedPassword(password,confirmPassword)
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

    func saveChanges() {
        // Validate input and update user profile
        guard let currentUser = viewModel.currentUser else {
            return
        }

       

        // Update user profile with new data
//      $viewModel.updateUserProfile(
//            userId: currentUser.id,
//            fullname: fullname,
//            email: email,
//            height: Double(height) ?? 0,
//            weight: Double(weight) ?? 0,
//            targetWeight: Double(targetWeight) ?? 0
//        )

        // Dismiss the view, or perform any other necessary action
        // For example:
        // presentationMode.wrappedValue.dismiss()
    }


}// struct

