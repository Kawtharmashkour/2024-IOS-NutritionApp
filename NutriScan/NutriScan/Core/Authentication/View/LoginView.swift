//
//  LoginView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-17.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                // image
                Image("nutrition")
                    .resizable()
                 .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.vertical,32)
                
     
                
                //form
                VStack(spacing: 24){
                    Inputview(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    Inputview(text: $password, title: "Password", placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top,12)
               
                
                //sign in button
                Button {
                    Task{
                        do{
                            try await viewModel.signIn(withEmail: email, password: password)
                            isLoggedIn = true
                        } catch {
                            let errorCode = (error as NSError).code
                            errorMessage = errorMessage(for: errorCode)
                        }
                    }
                } label: {
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                            
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
                }
                .background(Color(.systemGreen))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                
                NavigationLink(
                                   destination: AppView(),
                                   isActive: $isLoggedIn, // Activate the navigation link
                                   label: {
                                       EmptyView() // Empty view since navigation is performed programmatically
                                   }
                               )
                
                HStack {
                    Spacer() // Pushes the NavigationLink to the right
                    NavigationLink(
                        destination: ResetPasswordView(),
                        label: {
                            Text("Reset Password")
                                .font(.headline)
                                .foregroundColor(.green) // Set text color to green
                        }
                    )
                }
                .padding() // Add padding to the HStack if needed

                Spacer()
                //sign up button
               
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label :{
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                            
                            .foregroundColor(.green)
                            .font(.system(size: 16))
                    
                }
            }
        }
    }
    func errorMessage(for errorCode: Int) -> String {
        switch errorCode {
        case AuthErrorCode.wrongPassword.rawValue:
            return "Incorrect password. Please try again."
        case AuthErrorCode.userNotFound.rawValue:
            return "User not found. Please check your email and try again."
        case AuthErrorCode.networkError.rawValue:
            return "Network error. Please check your internet connection and try again."
        default:
            return "An error occurred. Please try again later."
        }
    }

}

//AuthenticationForm protocol
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        
    }
    
    
}

//#Preview {
//    LoginView( userProfile: <#UserProfile#>)
//}
