//
//  SignupItemGroupView.swift
//  NutriScan
//
//  Created by Shadan Farahbakhsh on 2024-03-24.
//

import SwiftUI
import FirebaseAuth

struct SignupItemGroupView: View {
    @EnvironmentObject var SignupVM: SignUpViewModel
    @StateObject var signUpViewModel = SignUpViewModel()
    @State var isLoggedin: Bool = false
    @State var errorMessage: String = ""
    @State var userGmail: String = "" // State variable to store the user's email address

    
    var body: some View {
        NavigationView {
            HStack(alignment: .center, spacing: 20) {
//                //FACEBOOK
//                Button {
//                    // Add your Facebook sign-in logic here
//                } label: {
//                    SignupItemView(backgroundColor: "facebookColor", image: "facebook")
//                }
//                
                //GOOGLE
               NavigationLink(destination: RegistrationView(gmail: userGmail), isActive: $isLoggedin) {
//              NavigationLink(destination: AppView(gmail: userGmail), isActive: $isLoggedin) {
                    Button(action: {
                        signUpViewModel.signUpWithGoogle()
                    }) {
                        SignupItemView(backgroundColor: "googleColor", image: "Google")
                    }
                }
                
                //TWITTER(X)
//                Button {
//                    // Add your Twitter sign-in logic here
//                } label: {
//                    SignupItemView(backgroundColor: "XColor", image: "x")
//                }
            }
        }
//        
        .onReceive(signUpViewModel.$isLogin) { isLoggedIn in
            if isLoggedIn {
                isLoggedin = true
                if let user = Auth.auth().currentUser {
                    userGmail = user.email ?? ""
                }
            } else {
                errorMessage = "Error Connecting to Gmail"
            }
        }
    }
}

#Preview {
    SignupItemGroupView()
}
