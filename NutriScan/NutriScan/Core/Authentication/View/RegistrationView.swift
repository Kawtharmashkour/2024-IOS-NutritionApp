//
//  RegistrationView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var weight = ""
    @State private var targetWeight = ""
    @State private var height = ""
    @State private var selectedGender : String? = "Male"
    let genders = ["Male","Female"]
 
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            Image("nutrition")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.vertical,5)
            
            VStack(alignment: .leading,spacing: 10){
                Inputview(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                Inputview(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                
                Inputview(text: $password, title: "Password", placeholder: "Enter your password",
                          isSecureField: true)
                
                Inputview(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
                
                
                Inputview(text: $height, title: "Height", placeholder: "Enter your height(cm)")
                    .keyboardType(.decimalPad)
                   
                
                Inputview(text: $weight, title: "Weight", placeholder: "Enter your weight(kg)")
                    .keyboardType(.decimalPad)
                
                
                Inputview(text: $targetWeight, title: "Target Weight", placeholder: "Enter your target (kg)")
                    .keyboardType(.decimalPad)
                
                Text("Gender")
                    .font(.subheadline)
                    .foregroundColor(.black)
                   
                HStack{
                    ForEach(genders, id: \.self) { gender in
                        Button(action: {
                            self.selectedGender = gender
                        }) {
                            HStack {
                                if self.selectedGender  == gender {
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
                
            }
                
            }
            .padding(.horizontal)
            .padding(.top, 3)
            
            Button {
                Task{
                    guard let gender = selectedGender else {
                              // Handle the case where the gender is not selected
                              return
                          }
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, weight: weight, height: height, targetWeight: targetWeight, gender: gender)
                    
                }
                
            } label: {
                HStack{
                    Text("SIGN Up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                    
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
            }
            .background(Color(.systemGreen))
            .cornerRadius(10)
            .padding(.bottom, 10)
            .padding(.top, 10)
            
            Spacer()
            Button {
                dismiss()
            }label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .foregroundColor(.green)
                .font(.system(size: 16))
            }
        }
    }

#Preview {
    RegistrationView()
}

