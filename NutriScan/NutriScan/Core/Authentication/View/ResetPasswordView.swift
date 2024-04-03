//
//  ResetPasswordView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-04-02.
//

import SwiftUI
import Firebase

struct ResetPasswordView: View {
    
    @State private var email = ""
    @State private var isResettingPassword = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
           
            // image
            Image("nutrihurt")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.top, -150)
               // .padding(.vertical,-10)
            
            HStack{
                Spacer()
                Text("Reset Password")
                    .font(.headline)
                    .padding(.bottom,20)
                Spacer()
            }
                
            Inputview(text: $email, title: "Enter your email address to recive confirmation email", placeholder: "your email address")
                .padding(20)
                   
                   Button(action: {
                       resetPassword()
                   }) {
                       Text("Rest Password")
                           .foregroundColor(.white)
                           .frame(width: UIScreen.main.bounds.width - 32 , height: 48)
                           .background(Color(.systemGreen))
//                           .disabled(!formIsValid)
//                           .opacity(formIsValid ? 1 : 0.5)
                           .cornerRadius(10)
                           .padding(.top, 20)
                   }
                   
               }// vstack
               
               .alert(isPresented: $showAlert) {
                   Alert(title: Text("Reset Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
               }
               .navigationTitle("")
           }
           
           private func resetPassword() {
               Auth.auth().sendPasswordReset(withEmail: email) { error in
                   if let error = error {
                       alertMessage = "Failed to reset password: \(error.localizedDescription)"
                   } else {
                       alertMessage = "Password reset email sent successfully."
                       //  navigate the user back to the previous screen or show a confirmation message.
                   }
                   showAlert = true
               }
           }
       }

#Preview {
    ResetPasswordView()
}
